import 'package:equatable/equatable.dart';

abstract class Model extends Equatable{
  static const int UNDEFINED_ID = -1;
  static const String UNDEFINED_VALUE = 'undefined';
  int id;
  Model({this.id = UNDEFINED_ID});
  toJsonLocal();
  toJson(){
    final json = Map<String, dynamic>();
    json.addAll({'id':id});
    json.addAll(toJsonLocal());
    return json;
  }
}