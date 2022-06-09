import 'package:kimp/memory_db/memory_db.dart';
import 'package:kimp/util/model.dart';
import 'package:kimp/util/repository.dart';

import 'quote_asset.dart';

class Market extends Model{
  final String name;
  final QuoteAsset quoteAsset;

  Market({required this.name, required this.quoteAsset});

  @override
  toJsonLocal() {
    return {'id':id, 'name':name, 'quoteassetid':quoteAsset.toJson()};
  }

  @override
  List<Object?> get props => [name, quoteAsset];
}

class MarketRepository extends Repository{
  MarketRepository():super(db:MemoryDB());
}