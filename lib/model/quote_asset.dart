import 'package:kimp/util/memory_db/memory_db.dart';
import 'package:kimp/util/model.dart';
import 'package:kimp/util/repository.dart';

class QuoteAsset extends Model{
  final String name;
  double rateperusd;

  QuoteAsset({id, required this.name, this.rateperusd = 0.0}):super(id:id);

  @override
  toJsonLocal() => {'name':name, 'rateperusd':rateperusd};

  @override
  List<Object?> get props => [name];

  factory QuoteAsset.fromJson(json){
    final id = json['id'];
    final name = json['name'];
    final rateperusd = json['rateperusd'];
    return QuoteAsset(id:id, name: name, rateperusd:rateperusd);
  }
}

class QuoteAssetRepository extends Repository{
  QuoteAssetRepository():super(db:MemoryDB());
}