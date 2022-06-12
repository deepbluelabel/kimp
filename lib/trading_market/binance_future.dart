import 'dart:convert';

import 'package:kimp/trading_market/trading_market.dart';
import 'package:http/http.dart' as http;

class BinanceFuture extends TradingMarket{
  BinanceFuture({market, adapter}) : super(market:market, adapter:adapter);

  @override
  fetchCurrencies() async{
    final uri = Uri.parse('https://fapi.binance.com/fapi/v1/exchangeInfo');
    try {
      final response = await http.get(uri);
      print('${market.name} fetch currencies ${response.statusCode.toString()}');
      return jsonDecode(response.body)['symbols'];
    }catch (e){
      print('${market.name} failed to fetch currencies ${e}');
      throw e;
    }
  }

  @override
  fetchPrice() async{
    final uri = Uri.parse('https://fapi.binance.com/fapi/v1/ticker/price');
    try{
      final response = await http.get(uri);
      print('${market.name} fetch prices ${response.statusCode.toString()}');
      return jsonDecode(response.body);
    }catch (e){
      print('${market.name} failed to fetch prices ${e}');
      throw e;
    }
  }
}