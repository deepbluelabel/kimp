import 'package:kimp/memory_db/memory_db.dart';
import 'package:kimp/util/model.dart';
import 'package:kimp/util/repository.dart';

import 'currency.dart';

class KimpPrice extends Model{
  final Currency currency;
  double rateperusd;

  KimpPrice({required this.currency, this.rateperusd = 0.0});

  @override
  toJsonLocal() => {'currency':currency.toJson(), 'rateperusd':rateperusd};

  @override
  List<Object?> get props => [currency];
}

class KimpPriceRepository extends Repository{
  KimpPriceRepository():super(db:MemoryDB());
}