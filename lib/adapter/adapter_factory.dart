import 'package:kimp/adapter/binance_future_to_currency.dart';
import 'package:kimp/adapter/upbit_to_currency.dart';
import 'package:kimp/model/currency.dart';

class AdapterFactory{
  static create<T>(String tradingMarketName){
    if (tradingMarketName == 'Upbit' && T == Currency)
      return UpbitToCurrency();
    if (tradingMarketName == 'BinanceFuture' && T == Currency)
      return BinanceFutureToCurrency();
  }
}