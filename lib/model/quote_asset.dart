import 'package:kimp/memory_db/memory_db.dart';
import 'package:kimp/util/model.dart';
import 'package:kimp/util/repository.dart';

class QuoteAsset extends Model{
  final id;
  final name;
  double rateperusd;

  QuoteAsset({this.id, this.name, this.rateperusd = 0.0});

  @override
  toJson() {
    return {'id':id, 'name':name, 'rateperusd':rateperusd};
  }
}

class QuoteAssetRepository extends Repository{
  QuoteAssetRepository():super(db:MemoryDB<QuoteAsset>()){
    db.add(QuoteAsset(id:0, name:'USDT'));
    db.add(QuoteAsset(id:1, name:'KRW'));
  }

  @override
  getAll() {
    return db.read();
  }
}