import 'package:kimp/memory_db/memory_db.dart';
import 'package:kimp/util/model.dart';
import 'package:kimp/util/repository.dart';

import 'currency.dart';
import 'market.dart';

class Price extends Model{
  final Currency currency;
  final Market market;
  double price;

  Price({required this.currency, required this.market, this.price = 0.0});

  @override
  toJsonLocal() {
    return {'currency':currency.toJson(), 'market':market.toJson(),
      'price':price};
  }

  @override
  List<Object?> get props => [currency, market];
}

class PriceRepository extends Repository{
  PriceRepository():super(db:MemoryDB());
}