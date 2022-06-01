import 'package:kimp/model/currency.dart';
import 'package:kimp/model/market.dart';
import 'package:kimp/model/price.dart';
import 'package:kimp/model/quote_asset.dart';
import 'package:kimp/trading_market/trading_market.dart';
import 'package:kimp/util/scheduler.dart';

class KimpController{
  final CurrencyRepository currencyRepository;
  final MarketRepository marketRepository;
  final PriceRepository priceRepository;
  final QuoteAssetRepository quoteAssetRepository;

  final scheduler = Scheduler();

  final tradingMarkets = <TradingMarket>[];

  init(){
    marketRepository.getAll()
        .map((e)=>TradingMarket.create(e.name)).toList()
        .forEach((e)=>tradingMarkets.add(e));
  }

  KimpController({required this.currencyRepository,
                  required this.marketRepository,
                  required this.priceRepository,
                  required this.quoteAssetRepository}){
    scheduler.addSchedule('every 5 seconds', '*/5 * * * * *', (name) {
      print ('${name} expired at ${DateTime.now().toString()}');
      tradingMarkets.forEach((e){
        e.fetchCurrencies();
      });
    });
  }
}