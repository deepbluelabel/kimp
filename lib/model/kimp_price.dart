import 'package:kimp/memory_db/memory_db.dart';
import 'package:kimp/util/model.dart';
import 'package:kimp/util/repository.dart';

import 'price.dart';

class KimpPrice extends Model{
  final Price base;
  final Price compare;
  double rateperusd;

  KimpPrice({required this.base, required this.compare, this.rateperusd = 0.0});

  @override
  toJsonLocal() => {'base':base.toJson(), 'compare':compare.toJson(),
    'rateperusd':rateperusd};

  @override
  List<Object?> get props => [base, compare];
}

class KimpPriceRepository extends Repository{
  KimpPriceRepository():super(db:MemoryDB());
}