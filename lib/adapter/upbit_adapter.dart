import 'package:kimp/model/currency.dart';
import 'package:kimp/model/price.dart';
import 'package:kimp/model/quote_asset.dart';
import 'package:kimp/adapter/kimp_adapter.dart';
import 'package:kimp/util/model.dart';

class UpbitAdapter extends KimpAdapter{
  UpbitAdapter({repositoryManager}):super(repositoryManager: repositoryManager);

  @override
  toCurrency(json) {
    final quoteAssetRepository = repositoryManager.get<QuoteAsset>();
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

  @override
  toMarketSymbol(currency) {
    return currency.quoteAsset.name+'-'+currency.symbol;
  }

  @override
  toPrice(json, obj) {
    final marketSymbol = toMarketSymbol(obj.currency);
    try{
      final price = json.where((e) => e['market'] == marketSymbol)
          .first['trade_price'];
      obj.price = price;
    }catch(e){
      obj.status = PriceStatus.UNAVAILABLE;
    }
    return obj;
  }
}