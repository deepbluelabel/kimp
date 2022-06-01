import 'dart:convert';

import 'package:kimp/trading_market/trading_market.dart';
import 'package:http/http.dart' as http;

class Upbit extends TradingMarket{
  @override
  fetchCurrencies() async{
    final uri = Uri.parse('https://api.upbit.com/v1/market/all');
    final response = await http.get(uri);
    print ('${name} fetch currencies ${response.statusCode.toString()}');
  }

  @override
  String name = 'Upbit';
}