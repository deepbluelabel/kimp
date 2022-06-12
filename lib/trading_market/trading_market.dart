import 'package:kimp/adapter/binance_future_adapter.dart';
import 'package:kimp/adapter/upbit_adapter.dart';
import 'package:kimp/model/market.dart';
import 'package:kimp/adapter/kimp_adapter.dart';

import 'binance_future.dart';
import 'upbit.dart';

abstract class TradingMarket{
  final Market market;
  final KimpAdapter adapter;
  TradingMarket({required this.market, required this.adapter}){
    print ('${runtimeType} is created');
  }

  fetchCurrencies();
  fetchPrice();

  factory TradingMarket.create(market, repositoryManager){
    switch (market.name){
      case 'BinanceFuture': return BinanceFuture(market:market,
        adapter:BinanceFutureAdapter(repositoryManager: repositoryManager));
      case 'Upbit': return Upbit(market:market,
        adapter:UpbitAdapter(repositoryManager: repositoryManager));
    }
    throw Exception('no trading market');
  }
}