import 'package:flutter/material.dart';
import 'package:kimp/controller/kimp_controller.dart';
import 'package:kimp/model/currency.dart';
import 'package:kimp/model/kimp_price.dart';
import 'package:kimp/model/market.dart';
import 'package:kimp/model/price.dart';
import 'package:kimp/model/quote_asset.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  _initController() async {
    final currencyRepository = CurrencyRepository();
    final marketRepository = MarketRepository();
    final priceRepository = PriceRepository();
    final quoteAssetRepository = QuoteAssetRepository();
    final kimpPriceRepository = KimpPriceRepository();
    final kimpController = KimpController(
        currencyRepository: currencyRepository,
        marketRepository: marketRepository,
        priceRepository: priceRepository,
        quoteAssetRepository: quoteAssetRepository,
        kimpPriceRepository: kimpPriceRepository)..init();
  }

  @override
  Widget build(BuildContext context) {
    _initController();
    return MaterialApp(
      home: Home()
    );
  }
}

class Home extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
