import 'package:kimp/memory_db/memory_db.dart';
import 'package:kimp/util/model.dart';
import 'package:kimp/util/repository.dart';

class Currency extends Model{
  final id;
  final String? name;
  final symbol;
  final quoteasset;

  Currency({this.id, this.name, this.symbol, this.quoteasset});

  @override
  toJson() {
    return {'id':id, 'name':name ?? Model.UNDEFINED_VALUE, 'symbol':symbol,
      'quoteAsset':quoteasset};
  }
}

class CurrencyRepository extends Repository{
  CurrencyRepository():super(db:MemoryDB<Currency>);

  @override
  getAll() {
  }
}