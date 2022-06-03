import 'dart:convert';

import 'package:kimp/trading_market/trading_market.dart';
import 'package:http/http.dart' as http;

class Upbit extends TradingMarket{
  @override
  fetchCurrencies() async{
    final uri = Uri.parse('https://api.upbit.com/v1/market/all');
    try {
      final response = await http.get(uri);
      print('${name} fetch currencies ${response.statusCode.toString()}');
      return jsonDecode(response.body);
    }catch (e){
      print('${name} failed to fetch currencies ${e}');
      throw e;
    }
  }

  @override
  String name = 'Upbit';
}