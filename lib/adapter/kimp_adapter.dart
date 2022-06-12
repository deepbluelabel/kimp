import 'package:kimp/model/currency.dart';
import 'package:kimp/model/price.dart';
import 'package:kimp/util/repository_manager.dart';

abstract class KimpAdapter{
  final RepositoryManager repositoryManager;

  KimpAdapter({required this.repositoryManager});

  fromJson<T>(json, {T? obj}){
    if(T == Currency) return toCurrency(json);
    if(T == Price) return toPrice(json, obj);
  }

  toCurrency(json);
  toPrice(json, obj);
  toMarketSymbol(currency);
}