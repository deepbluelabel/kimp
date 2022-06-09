import 'package:kimp/memory_db/memory_db.dart';
import 'package:kimp/util/model.dart';
import 'package:kimp/util/repository.dart';

class QuoteAsset extends Model{
  final String name;
  double rateperusd;

  QuoteAsset({required this.name, this.rateperusd = 0.0});

  @override
  toJsonLocal() => {'name':name, 'rateperusd':rateperusd};

  @override
  List<Object?> get props => [name];
}

class QuoteAssetRepository extends Repository{
  QuoteAssetRepository():super(db:MemoryDB());
}