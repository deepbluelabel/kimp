import 'package:kimp/memory_db/memory_db.dart';
import 'package:kimp/util/model.dart';
import 'package:kimp/util/repository.dart';

class Currency extends Model{
  final id;
  final name;
  final symbol;

  Currency({this.id, this.name, this.symbol});
}

class CurrencyRepository extends Repository{
  CurrencyRepository():super(db:MemoryDB<Currency>);

  @override
  getAll() {
  }
}