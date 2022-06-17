import 'package:kimp/util/memory_db/memory_db.dart';
import 'package:kimp/util/model.dart';
import 'package:kimp/util/repository.dart';

import 'currency.dart';
import 'market.dart';

enum PriceStatus {AVAILABLE, UNAVAILABLE}
class Price extends Model{
  final Currency currency;
  final Market market;
  double price;
  PriceStatus status;

  Price({id, required this.currency, required this.market, this.price = 0.0,
         this.status = PriceStatus.AVAILABLE}):super(id:id);

  @override
  toJsonLocal() {
    return {'currency':currency.toJson(), 'market':market.toJson(),
      'price':price, 'status':status.index};
  }

  @override
  List<Object?> get props => [currency, market];

  factory Price.fromJson(json){
    final id = json['id'];
    final currency = Currency.fromJson(json['currency']);
    final market = Market.fromJson(json['market']);
    final price = json['price'];
    final status = PriceStatus.values[json['status']];
    return Price(id:id, currency: currency, market:market, price: price,
        status: status);
  }
}

class PriceRepository extends Repository{
  PriceRepository():super(db:MemoryDB());
}