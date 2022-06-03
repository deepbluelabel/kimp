import 'package:kimp/model/currency.dart';
import 'package:kimp/util/adapter.dart';
import 'package:kimp/util/model.dart';

class UpbitToCurrency implements Adapter{
  @override
  fromJson(json) {
    final symbols = json['market'].split('-');
    final quoteAsset = symbols[0];
    final symbol = symbols[1];
    return Currency(id:Model.UNDEFINED_ID, name:json['english_name'],
        symbol:symbol, quoteasset: quoteAsset);
  }
}