import 'package:kimp/model/market.dart';

import 'binance_future.dart';
import 'upbit.dart';

abstract class TradingMarket{
  final Market market;
  TradingMarket({required this.market}){
    print ('${runtimeType} is created');
  }

  fetchCurrencies();

  factory TradingMarket.create(market){
    switch (market.name){
      case 'BinanceFuture': return BinanceFuture(market:market);
      case 'Upbit': return Upbit(market:market);
    }
    throw Exception('no trading market');
  }
}