import 'package:kimp/util/model.dart';
import 'package:kimp/util/nosql_db/nosql_adapter.dart';
import 'package:kimp/util/nosql_db/nosql_db.dart';
import 'package:kimp/util/repository.dart';

class Setting extends Model{
  final preferred = <dynamic>[];

  Setting({id, preferred}){
    if (preferred != null) this.preferred.addAll(preferred);
  }

  @override
  List<Object?> get props => [preferred];

  @override
  toJsonLocal() {
    return {'preferred':preferred};
  }

  factory Setting.fromJson(json){
    final preferred = json['preferred'];
    return Setting(preferred: preferred);
  }
}

class SettingRepository extends Repository{
  SettingRepository():super(db:NosqlDB()
      ..connect('Setting', SettingNosqlAdapter()));
}

class SettingNosqlAdapter extends NosqlAdapter{
  @override
  fromJson(json) => Setting.fromJson(json);

  @override
  toJson(obj) => obj.toJson();
}