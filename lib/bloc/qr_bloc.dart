import 'dart:async';
import 'package:appcheck/database/table_sql.dart';

import '../event/add_data.dart';
import '../event/delete_data.dart';
import 'package:appcheck/base/base_bloc.dart';
import 'package:appcheck/base/base_event.dart';
import 'dart:math';
import '../model/qr_data.dart';

class QrBloc extends BaseBloc {
  StreamController<List<QRdata>> _qrListstreamController =
      StreamController<List<QRdata>>();

  Stream<List<QRdata>> get qrList => _qrListstreamController.stream;

  TableSql _tableSql = TableSql();

  var _random = Random();
  List<QRdata> _qrDataList = List<QRdata>();

  initData() async {
     _qrDataList = await _tableSql.selectAll();

     if(_qrDataList == null){
       return;
     }
     _qrListstreamController.sink.add(_qrDataList);
  }

  _addQR(QRdata qRdata) async {
    //add
    await _tableSql.insert(qRdata);


    _qrDataList.add(qRdata);
    _qrListstreamController.sink.add(_qrDataList);
  }

  _deleteQR(QRdata qRdata) async {
    await _tableSql.delete(qRdata);


    _qrDataList.remove(qRdata);
    _qrListstreamController.sink.add(_qrDataList);
  }

  @override
  void dispatchevent(BaseEvent event) {
    if (event is AddDataEvent) {
      QRdata qRdata = new QRdata.fromData(
        _random.nextInt(1000000),
        event.content,
      );
      _addQR(qRdata);
      print(event.content);
    } else if (event is DeleteDataEvent) {
      _deleteQR(event.qRdata);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _qrListstreamController.close();
  }
}
