import 'package:kimp/util/database.dart';
import 'package:kimp/util/model.dart';

class MemoryDB extends Database{
  final records = <Model>[];

  @override
  read() {
    return records;
  }

  @override
  add(record) {
    if(_isExist(record) == false) {
      if (record.id == Model.UNDEFINED_ID) record.id = _getNewId();
      records.add(record);
    }
  }

  _getNewId(){
    if (records.isEmpty) return 0;
    return records.last.id+1;
  }

  _isExist(record) => records.any((e)=>e==record);
}