import 'package:kimp/util/memory_db/memory_db.dart';
import 'package:kimp/util/model.dart';
import 'package:kimp/util/repository.dart';

import 'quote_asset.dart';

class Currency extends Model{
  final String name;
  final String symbol;
  final QuoteAsset quoteAsset;

  Currency({id, this.name = Model.UNDEFINED_VALUE,
    required this.symbol, required this.quoteAsset}):super(id:id);

  @override
  toJsonLocal() {
    return {'name':name, 'symbol':symbol, 'quoteAsset':quoteAsset.toJson()};
  }

  @override
  List<Object?> get props => [symbol, quoteAsset];

  factory Currency.fromJson(json){
    final id = json['id'];
    final name = json['name'];
    final symbol = json['symbol'];
    final quoteAsset = QuoteAsset.fromJson(json['quoteAsset']);
    return Currency(id:id, name:name, symbol:symbol, quoteAsset:quoteAsset);
  }
}

class CurrencyRepository extends Repository{
  CurrencyRepository():super(db:MemoryDB());
}