import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kimp/model/currency.dart';
import 'package:kimp/model/kimp_price.dart';
import 'package:kimp/model/market.dart';
import 'package:kimp/model/price.dart';
import 'package:kimp/model/quote_asset.dart';
import 'package:kimp/model/setting.dart';
import 'package:kimp/trading_market/trading_market.dart';
import 'package:kimp/util/repository_manager.dart';
import 'package:kimp/util/scheduler.dart';

enum KimpControllerState {NOTINIT, ALL, PREFERRED}
class KimpController extends GetxController{
  final RepositoryManager repositoryManager;
  late CurrencyRepository currencyRepository;
  late MarketRepository marketRepository;
  late PriceRepository priceRepository;
  late QuoteAssetRepository quoteAssetRepository;
  late KimpPriceRepository kimpPriceRepository;
  late SettingRepository settingRepository;
  final state = KimpControllerState.NOTINIT.obs;

  final scheduler = Scheduler();

  final tradingMarkets = <TradingMarket>[];
  final kimpPrices = <KimpPrice>[].obs;
  QuoteAsset quoteAssetUSDT = QuoteAsset(name:'USDT', rateperusd: 1.0);
  QuoteAsset quoteAssetKRW = QuoteAsset(name:'KRW');
  late Setting setting;
  final krwPerUSD = (0.0).obs;

  init() async{
    currencyRepository = repositoryManager.get<Currency>();
    marketRepository = repositoryManager.get<Market>();
    quoteAssetRepository = repositoryManager.get<QuoteAsset>();
    priceRepository = repositoryManager.get<Price>();
    kimpPriceRepository = repositoryManager.get<KimpPrice>();
    settingRepository = repositoryManager.get<Setting>();
    await quoteAssetRepository.add(quoteAssetUSDT);
    await quoteAssetRepository.add(quoteAssetKRW);
    Market marketUpbit = Market(name:'Upbit', quoteAsset: quoteAssetKRW);
    Market marketBinanceFuture = Market(name:'BinanceFuture',
        quoteAsset: quoteAssetUSDT);
    await marketRepository.add(marketUpbit);
    await marketRepository.add(marketBinanceFuture);
    marketRepository.getAll()
        .map((e)=>TradingMarket.create(e, repositoryManager)).toList()
        .forEach((e){
          tradingMarkets.add(e);
    });
    await _fetchCurrencies();
    scheduler.addSchedule('fetch prices', '*/3 * * * * *', (name) async{
      print ('${name} expired at ${DateTime.now().toString()}');
      await _fetchPrices();
      krwPerUSD.value = quoteAssetKRW.rateperusd = await _getUSDKRW();
      await kimpPriceRepository.getAll().forEach((e) => _calcKimp(e));
      if (state == KimpControllerState.NOTINIT) {
        setState(KimpControllerState.ALL);
        _loadSetting();
      }
      kimpPrices.refresh();
    });
    scheduler.addSchedule('fetch currencies', '0 0 * * * *', (name) async{
      print ('${name} expired at ${DateTime.now().toString()}');
      await _fetchCurrencies();
    });
  }

  KimpController({required this.repositoryManager});

  setState(value) async{
    if (state != value){
      state.value = value;
      kimpPrices.clear();
      if (value == KimpControllerState.PREFERRED)
        await kimpPriceRepository.getAll()
          .where((e) => e.preferred == true)
          .forEach((e) => kimpPrices.add(e));
      else
        await kimpPriceRepository.getAll().forEach((e) => kimpPrices.add(e));
      kimpPrices.refresh();
    }
  }

  togglePreferred(KimpPrice kimpPrice){
    kimpPrice.preferred = !kimpPrice.preferred;
    setting.preferred.clear();
    setting.preferred.addAll(kimpPrices.where((e) => e.preferred)
      .map((e)=>e.base.currency.symbol).toList());
    settingRepository.update(setting);
    kimpPrices.refresh();
  }

  _loadSetting() async{
    if (settingRepository.isEmpty){
      setting = Setting();
      await settingRepository.add(setting);
    }else
      setting = settingRepository.getAll().first;
    kimpPrices.forEach((e){
      if (setting.preferred.contains(e.base.currency.symbol))
        e.preferred = true;
    });
  }

  _calcKimp(e){
    final baseUSD = (e.base.price/quoteAssetKRW.rateperusd).toDouble();
    final compareUSD = (e.compare.price/quoteAssetUSDT.rateperusd).toDouble();
    e.rateperusd = (baseUSD-compareUSD)/compareUSD*100.0;
  }

  _getUSDKRW() async{
    final uri = Uri.parse('https://quotation-api-cdn.dunamu.com/v1/'+
        'forex/recent?codes=FRX.KRWUSD');
    try{
      final response = await http.get(uri);
      final exchange = jsonDecode(response.body)[0]['basePrice'];
      return exchange;
    }catch (e){
      print (e);
    }
  }

  _fetchPrices() async{
    for (final tradingMarket in tradingMarkets){
      try{
        final json = await tradingMarket.fetchPrice();
        final adapter = tradingMarket.adapter;
        final prices = await priceRepository
            .get((e) => e.market == tradingMarket.market);
        await prices.forEach((e) {adapter.fromJson<Price>(json, obj:e);});
      }catch (e){
        print (e);
      }
    }
  }

  _fetchCurrencies() async{
    for(final tradingMarket in tradingMarkets){
      try {
        final json = await tradingMarket.fetchCurrencies();
        final adapter = tradingMarket.adapter;
        await json.map((e) => adapter.fromJson<Currency>(e))
            .forEach((e) async{
          var currency = e;
          if (await currencyRepository.add(e) == false)
            currency = currencyRepository
                .get((currency)=>e==currency).first;
          final market = tradingMarket.market;
          if (market.quoteAsset == currency.quoteAsset){
            final price = Price(currency: currency,
                market: tradingMarket.market);
            await priceRepository.add(price);
          }
        });
      }catch (e){
        print (e);
      }
    }
    await _getKimp('Upbit', 'BinanceFuture');
    print(kimpPriceRepository.getAll().map((e)=>e.base.currency.symbol));
  }

  _getKimp(String marketName, String compareName) async{
    final marketPrices = await priceRepository
        .get((e)=>e.market.name==marketName);
    final comparePrices = await priceRepository
        .get((e)=>e.market.name==compareName);
    for (final marketPrice in marketPrices){
      if (comparePrices
          .any((e)=>e.currency.symbol==marketPrice.currency.symbol)) {
        final compare = comparePrices
            .where((e) => e.currency.symbol == marketPrice.currency.symbol)
            .first;
        await kimpPriceRepository
            .add(KimpPrice(base: marketPrice, compare: compare));
      }
    }
  }
}