import 'dart:convert';

import 'package:kimp/trading_market/trading_market.dart';
import 'package:http/http.dart' as http;

class BinanceFuture extends TradingMarket{
  @override
  fetchCurrencies() async{
    final uri = Uri.parse('https://fapi.binance.com/fapi/v1/exchangeInfo');
    try {
      final response = await http.get(uri);
      print('${name} fetch currencies ${response.statusCode.toString()}');
      return jsonDecode(response.body)['symbols'];
    }catch (e){
      print('${name} failed to fetch currencies ${e}');
      throw e;
    }
  }

  @override
  String name = 'BinanceFuture';
}