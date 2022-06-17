import 'dart:convert';

import 'package:kimp/util/database.dart';
import 'package:kimp/util/model.dart';
import 'package:kimp/util/nosql_db/nosql_adapter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NosqlDB extends Database{
  final records = <Model>[];
  late var prefs;
  late String name;
  late NosqlAdapter adapter;
  int counts = 0;

  @override
  add(record) async {
    if(_isExist(record) == false) {
      if (record.id == Model.UNDEFINED_ID) record.id = _getNewId();
      records.add(record);
      counts = records.last.id! + 1;
      await prefs.setInt(name+'counts', counts);
      await update(record);
      return true;
    }
    return false;
  }

  _getNewId(){
    if (records.isEmpty) return 0;
    return records.last.id!+1;
  }

  _isExist(record) => records.any((e)=>e==record);

  @override
  read() {
    return records;
  }

  _load() async{
    counts = await prefs.getInt(name+'counts') ?? 0;
    for (int i = 1; i <= counts; i++){
      final saved = await prefs.getString(name+i.toString());
      if (saved != null){
        final json = jsonDecode(saved);
        final record = adapter.fromJson(json) as Model;
        records.add(record);
      }
    }
  }

  @override
  connect(name, adapter) async {
    this.name = name;
    this.adapter = adapter;
    prefs = await SharedPreferences.getInstance();
    await _load();
    return this;
  }

  @override
  delete(record) {
  }

  @override
  update(record) async{
    await prefs.setString(name+counts.toString(),
        jsonEncode(adapter.toJson(record)));
  }
}