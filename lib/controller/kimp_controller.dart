import 'package:kimp/adapter/adapter_factory.dart';
import 'package:kimp/model/currency.dart';
import 'package:kimp/model/market.dart';
import 'package:kimp/model/price.dart';
import 'package:kimp/model/quote_asset.dart';
import 'package:kimp/trading_market/trading_market.dart';
import 'package:kimp/util/adapter.dart';
import 'package:kimp/util/scheduler.dart';

class KimpController{
  final CurrencyRepository currencyRepository;
  final MarketRepository marketRepository;
  final PriceRepository priceRepository;
  final QuoteAssetRepository quoteAssetRepository;

  final scheduler = Scheduler();

  final tradingMarkets = <TradingMarket>[];
  final currencyAdapters = Map<String, Adapter>();

  init(){
    marketRepository.getAll()
        .map((e)=>TradingMarket.create(e.name)).toList()
        .forEach((e){
          currencyAdapters[e.name] = AdapterFactory.create<Currency>(e.name);
          tradingMarkets.add(e);
    });
  }

  KimpController({required this.currencyRepository,
                  required this.marketRepository,
                  required this.priceRepository,
                  required this.quoteAssetRepository}){
    scheduler.addSchedule('every 5 seconds', '*/5 * * * * *', (name) {
      print ('${name} expired at ${DateTime.now().toString()}');
      tradingMarkets.forEach((e) async{
        try {
          final json = await e.fetchCurrencies();
          final adapter = currencyAdapters[e.name];
          final currencies = json.map((e) => adapter!.fromJson(e));
          print ('${currencies.length} ${currencies.first.toJson()}');
        }catch (e){}

      });
    });
  }
}