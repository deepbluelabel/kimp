import 'package:kimp/model/currency.dart';
import 'package:kimp/model/price.dart';
import 'package:kimp/model/quote_asset.dart';
import 'package:kimp/adapter/kimp_adapter.dart';

class BinanceFutureAdapter extends KimpAdapter{
  BinanceFutureAdapter({repositoryManager})
      :super(repositoryManager: repositoryManager);

  @override
  toCurrency(json) {
    final quoteAssetRepository = repositoryManager.get<QuoteAsset>();
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

  @override
  toPrice(json, obj) {
    final marketSymbol = toMarketSymbol(obj.currency);

    try{
      final price = json.where((e) => e['symbol'] == marketSymbol)
          .first['price'];
      obj.price = double.parse(price);
    }catch (e){
      obj.status = PriceStatus.UNAVAILABLE;
    }
    return obj;
  }

  @override
  toMarketSymbol(currency) {
    return currency.symbol+currency.quoteAsset.name;
  }
}