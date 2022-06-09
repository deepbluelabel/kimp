import 'package:kimp/model/currency.dart';
import 'package:kimp/model/quote_asset.dart';
import 'package:kimp/util/adapter.dart';

class BinanceFutureToCurrency implements Adapter{
  final quoteAssetRepository;
  BinanceFutureToCurrency({this.quoteAssetRepository});

  @override
  fromJson(json) {
    final symbol = json['baseAsset'];
    final quoteAssets = quoteAssetRepository
        .get((e)=>e.name==json['quoteAsset']);
    var quoteAsset;
    if (quoteAssets.length <= 0) {
      quoteAsset = QuoteAsset(name: json['quoteAsset']);
      quoteAssetRepository.add(quoteAsset);
    }else quoteAsset = quoteAssets.first;
    return Currency(symbol: symbol, quoteAsset: quoteAsset);
  }
}