import 'package:cron/cron.dart';

typedef ScheduledCallback = void Function(String name);
class Scheduler{
  final cron = Cron();

  addSchedule(String name, String expression, ScheduledCallback callback){
    cron.schedule(Schedule.parse(expression), () => callback(name));
  }
}