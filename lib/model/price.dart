import 'package:kimp/memory_db/memory_db.dart';
import 'package:kimp/util/model.dart';
import 'package:kimp/util/repository.dart';

class Price extends Model{
  final currencyid;
  final marketid;
  final price;

  Price({this.currencyid, this.marketid, this.price});

  @override
  toJson() {
    return {'currencyid':currencyid, 'marketid':marketid, 'price':price};
  }
}

class PriceRepository extends Repository{
  PriceRepository():super(db:MemoryDB<Price>);

  @override
  getAll() {
  }
}