import 'binance_future.dart';
import 'upbit.dart';

abstract class TradingMarket{
  TradingMarket(){
    print ('${runtimeType} is created');
  }

  abstract String name;
  fetchCurrencies();

  factory TradingMarket.create(String name){
    switch (name){
      case 'BinanceFuture': return BinanceFuture();
      case 'Upbit': return Upbit();
    }
    throw Exception('no trading market');
  }
}