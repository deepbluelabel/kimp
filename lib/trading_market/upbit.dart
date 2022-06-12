import 'dart:convert';

import 'package:kimp/model/price.dart';
import 'package:kimp/trading_market/trading_market.dart';
import 'package:http/http.dart' as http;

class Upbit extends TradingMarket{
  Upbit({market, adapter}) : super(market:market, adapter:adapter);

  @override
  fetchCurrencies() async{
    final uri = Uri.parse('https://api.upbit.com/v1/market/all');
    try {
      final response = await http.get(uri);
      print('${market.name} fetch currencies ${response.statusCode.toString()}');
      return jsonDecode(response.body);
    }catch (e){
      print('${market.name} failed to fetch currencies ${e}');
      throw e;
    }
  }

  @override
  fetchPrice() async{
    final priceRepository = adapter.repositoryManager.get<Price>();
    final currencies = priceRepository.get((e) => e.market == market)
        .map((e) => e.currency);
    final symbolBuffer = StringBuffer();
    currencies.forEach((e) => symbolBuffer.writeln(adapter.toMarketSymbol(e)));
    final length = symbolBuffer.length;
    final symbols = symbolBuffer.toString().replaceAll('\n',',')
        .substring(0, length-1);
    final uri = Uri.parse('https://api.upbit.com/v1/ticker?markets='+symbols);
    try {
      final response = await http.get(uri);
      print('${market.name} fetch prices ${response.statusCode.toString()}');
      return jsonDecode(response.body);
    }catch (e){
      print('${market.name} failed to fetch prices ${e}');
      throw e;
    }
  }
}