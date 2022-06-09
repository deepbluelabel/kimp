import 'package:kimp/model/currency.dart';
import 'package:kimp/model/quote_asset.dart';
import 'package:kimp/util/adapter.dart';
import 'package:kimp/util/model.dart';

class UpbitToCurrency implements Adapter{
  final quoteAssetRepository;
  UpbitToCurrency({this.quoteAssetRepository});

@override
  fromJson(json) {
    final symbols = json['market'].split('-');
    final symbol = symbols[1];
    final quoteAssets = quoteAssetRepository.get((e)=>e.name==symbols[0]);
    var quoteAsset;
    if (quoteAssets.length <= 0) {
      quoteAsset = QuoteAsset(name: symbols[0]);
      quoteAssetRepository.add(quoteAsset);
    }else quoteAsset = quoteAssets.first;
    return Currency(name: json['english_name'], symbol: symbol,
        quoteAsset: quoteAsset);
  }
}