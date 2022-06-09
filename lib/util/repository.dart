typedef Where = bool Function(dynamic e);
abstract class Repository{
  final db;

  Repository({this.db});

  getAll() => db.read();

  add(item){
    db.add(item);
    return item.id;
  }

  get(Where where){
    return db.read().where((e)=>where(e));
  }
}