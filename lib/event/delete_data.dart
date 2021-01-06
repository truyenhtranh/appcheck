import 'package:appcheck/base/base_event.dart';
import 'package:appcheck/model/qr_data.dart';

class DeleteDataEvent extends BaseEvent {
QRdata qRdata;
DeleteDataEvent(this.qRdata);

}