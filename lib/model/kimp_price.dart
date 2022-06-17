import 'package:kimp/util/memory_db/memory_db.dart';
import 'package:kimp/util/model.dart';
import 'package:kimp/util/repository.dart';

import 'price.dart';

class KimpPrice extends Model{
  final Price base;
  final Price compare;
  double rateperusd;
  bool preferred;

  KimpPrice({id, required this.base, required this.compare,
    this.rateperusd = 0.0, this.preferred = false}):super(id:id);

  @override
  toJsonLocal() => {'base':base.toJson(), 'compare':compare.toJson(),
    'rateperusd':rateperusd, 'preferred':preferred};

  @override
  List<Object?> get props => [base, compare];

  factory KimpPrice.fromJson(json){
    final id = json['id'];
    final base = Price.fromJson(json['base']);
    final compare = Price.fromJson(json['compare']);
    final rateperusd = json['rateperusd'];
    final preferred = json['preferred'];
    return KimpPrice(id:id, base: base, compare: compare,
        rateperusd: rateperusd, preferred: preferred);
  }
}

class KimpPriceRepository extends Repository{
  KimpPriceRepository():super(db:MemoryDB());
}