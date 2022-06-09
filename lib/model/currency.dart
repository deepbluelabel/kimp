import 'package:kimp/memory_db/memory_db.dart';
import 'package:kimp/util/model.dart';
import 'package:kimp/util/repository.dart';

import 'quote_asset.dart';

class Currency extends Model{
  final String name;
  final String symbol;
  final QuoteAsset quoteAsset;

  Currency({id, this.name = Model.UNDEFINED_VALUE,
    required this.symbol, required this.quoteAsset});

  @override
  toJsonLocal() {
    return {'name':name, 'symbol':symbol, 'quoteAsset':quoteAsset.toJson()};
  }

  @override
  List<Object?> get props => [symbol, quoteAsset];
}

class CurrencyRepository extends Repository{
  CurrencyRepository():super(db:MemoryDB());
}