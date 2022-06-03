import 'package:kimp/model/currency.dart';
import 'package:kimp/util/adapter.dart';
import 'package:kimp/util/model.dart';

class BinanceFutureToCurrency implements Adapter{
  @override
  fromJson(json) {
    final symbol = json['baseAsset'];
    final quoteAsset = json['quoteAsset'];
    return Currency(id:Model.UNDEFINED_ID, symbol: symbol,
        quoteasset: quoteAsset);
  }
}