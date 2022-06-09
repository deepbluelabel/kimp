import 'package:kimp/adapter/binance_future_to_currency.dart';
import 'package:kimp/adapter/upbit_to_currency.dart';
import 'package:kimp/model/currency.dart';
import 'package:kimp/model/kimp_price.dart';
import 'package:kimp/model/market.dart';
import 'package:kimp/model/price.dart';
import 'package:kimp/model/quote_asset.dart';
import 'package:kimp/trading_market/trading_market.dart';
import 'package:kimp/util/adapter.dart';
import 'package:kimp/util/model.dart';
import 'package:kimp/util/scheduler.dart';

class KimpController{
  final CurrencyRepository currencyRepository;
  final MarketRepository marketRepository;
  final PriceRepository priceRepository;
  final QuoteAssetRepository quoteAssetRepository;
  final KimpPriceRepository kimpPriceRepository;

  final scheduler = Scheduler();

  final tradingMarkets = <TradingMarket>[];
  final currencyAdapters = Map<String, Adapter>();

  init(){
    QuoteAsset quoteAssetUSDT = QuoteAsset(name:'USDT');
    QuoteAsset quoteAssetKRW = QuoteAsset(name:'KRW');
    quoteAssetRepository.add(quoteAssetUSDT);
    quoteAssetRepository.add(quoteAssetKRW);
    Market marketUpbit = Market(name:'Upbit', quoteAsset: quoteAssetKRW);
    Market marketBinanceFuture = Market(name:'BinanceFuture',
        quoteAsset: quoteAssetUSDT);
    marketRepository.add(marketUpbit);
    marketRepository.add(marketBinanceFuture);
    marketRepository.getAll()
        .map((e)=>TradingMarket.create(e)).toList()
        .forEach((e){
          currencyAdapters[e.market.name] = _createCurrencyAdapter(e.market);
          tradingMarkets.add(e);
    });
  }

  KimpController({required this.currencyRepository,
                  required this.marketRepository,
                  required this.priceRepository,
                  required this.quoteAssetRepository,
                  required this.kimpPriceRepository}){
    scheduler.addSchedule('every 5 seconds', '*/5 * * * * *', (name) async{
      print ('${name} expired at ${DateTime.now().toString()}');
      for(final tradingMarket in tradingMarkets){
        try {
          final json = await tradingMarket.fetchCurrencies();
          final adapter = currencyAdapters[tradingMarket.market.name];
          await json.map((e) => adapter!.fromJson(e))
              .forEach((currency) {
                final id = currencyRepository.add(currency);
                final market = tradingMarket.market;
                if (id != Model.UNDEFINED_ID
                    && market.quoteAsset == currency.quoteAsset){
                  final price = Price(currency: currency,
                                      market: tradingMarket.market);
                  priceRepository.add(price);
                }
          });
        }catch (e){
          print (e);
        }
      }
      await _getKimp('Upbit', 'BinanceFuture');
      print(kimpPriceRepository.getAll().map((e)=>e.currency.symbol));
    });
  }

  _getKimp(String marketName, String compareName) async{
    final marketCurrencies = await priceRepository
        .get((e)=>e.market.name==marketName)
        .map((e)=>e.currency);
    final compareCurrencies = await priceRepository
        .get((e)=>e.market.name==compareName)
        .map((e)=>e.currency);
    for (final marketCurrency in marketCurrencies){
      if (compareCurrencies.any((e)=>e.symbol==marketCurrency.symbol))
        kimpPriceRepository.add(KimpPrice(currency: marketCurrency));
    }
  }

  _createCurrencyAdapter(market){
    switch(market.name){
      case 'Upbit':
        return UpbitToCurrency(quoteAssetRepository: quoteAssetRepository);
      case 'BinanceFuture':
        return BinanceFutureToCurrency(
            quoteAssetRepository: quoteAssetRepository);
    }
  }
}