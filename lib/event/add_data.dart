import 'package:appcheck/base/base_event.dart';

class AddDataEvent extends BaseEvent{
  String content;
  AddDataEvent(this.content);
}