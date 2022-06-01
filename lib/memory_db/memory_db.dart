import 'package:kimp/util/database.dart';

class MemoryDB<T> extends Database{
  final records = <T>[];

  @override
  read() {
    return records;
  }

  @override
  add(record) {
    records.add(record);
  }
}