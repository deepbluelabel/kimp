import 'package:kimp/util/memory_db/memory_db.dart';
import 'package:kimp/util/model.dart';
import 'package:kimp/util/repository.dart';

import 'quote_asset.dart';

class Market extends Model{
  final String name;
  final QuoteAsset quoteAsset;

  Market({id, required this.name, required this.quoteAsset}):super(id:id);

  @override
  toJsonLocal() {
    return {'name':name, 'quoteAsset':quoteAsset.toJson()};
  }

  @override
  List<Object?> get props => [name, quoteAsset];

  factory Market.fromJson(json){
    final id = json['id'];
    final name = json['name'];
    final quoteAsset = QuoteAsset.fromJson(json['quoteAsset']);
    return Market(id:id, name:name, quoteAsset: quoteAsset);
  }
}

class MarketRepository extends Repository{
  MarketRepository():super(db:MemoryDB());
}