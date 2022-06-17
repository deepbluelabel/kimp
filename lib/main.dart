import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kimp/controller/kimp_controller.dart';
import 'package:kimp/model/currency.dart';
import 'package:kimp/model/kimp_price.dart';
import 'package:kimp/model/market.dart';
import 'package:kimp/model/price.dart';
import 'package:kimp/model/quote_asset.dart';
import 'package:kimp/model/setting.dart';

import 'util/repository_manager.dart';
import 'widget/kimp_list_widget.dart';
import 'widget/kimp_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  _initController() async {
    final repositoryManager = RepositoryManager();
    repositoryManager.add<Currency>(CurrencyRepository());
    repositoryManager.add<Market>(MarketRepository());
    repositoryManager.add<Price>(PriceRepository());
    repositoryManager.add<QuoteAsset>(QuoteAssetRepository());
    repositoryManager.add<KimpPrice>(KimpPriceRepository());
    repositoryManager.add<Setting>(SettingRepository());
    final kimpController = KimpController(
      repositoryManager: repositoryManager)..init();
    Get.put(kimpController);
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
    return KimpWidget();
  }
}
