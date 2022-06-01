import 'package:kimp/memory_db/memory_db.dart';
import 'package:kimp/util/model.dart';
import 'package:kimp/util/repository.dart';

class Market extends Model{
  final id;
  final name;
  final quoteassetid;

  Market({this.id, this.name, this.quoteassetid});
}

class MarketRepository extends Repository{
  MarketRepository():super(db:MemoryDB<Market>()){
    db.add(Market(id:0, name:'BinanceFuture', quoteassetid: 0));
    db.add(Market(id:1, name:'Upbit', quoteassetid: 1));
  }

  @override
  getAll() {
    return db.read();
  }
}