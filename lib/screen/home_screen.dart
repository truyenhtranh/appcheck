import 'package:appcheck/bloc/qr_bloc.dart';
import 'package:appcheck/event/add_data.dart';
import 'package:appcheck/screen/test.dart';
import 'package:appcheck/screen/webviewcontainer.dart';
import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'my_body_home.dart';
import 'noidung.dart';
import '../database/data_list_class.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String data;
  List<String> abc = [];
  String body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Icon(
          Icons.qr_code_outlined,
          color: Colors.blue,
          size: 40,
        ),
        title: Text(
          "QR Check",
          style: TextStyle(
            color: Colors.blue.shade600,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.map,
                color: Colors.blue,
                size: 40,
              ),
              onPressed: () {}),
        ],
      ),
      body: MyBodyHome(),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.qr_code_scanner,
          size: 35,
        ),
        backgroundColor: Colors.blue.shade900,
        onPressed: () async {
          String barcodeScanRes = await scanner.scan();

            // cài đặt tham số POST request
            String url = 'http://testqrcode.nanoweb.vn/api/app/code/get-code';

            // Map<String, String> headers = {"Content-type": "application/json"};

            Map json = {
              'code': '$barcodeScanRes',
              'latlng': '21,103',
              'imei': '1234555'
            };
            // tạo POST request
            Response response = await post(url, body: json);
            // kiểm tra status code của kết quả response
            int statusCode = response.statusCode;
            // API này trả về id của item mới được add trong body
            body = response.body;

          if (body.startsWith("http")) {
            data = body;
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => WebViewContainer(
                          url: data,
                        )));
          } else {
            data = body;
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NoiDung(
                          noidung: data,
                        )));
          }

          setState(() {
            abc.add(data);
            lvData.add(data);
            getData();
          });
        },
      ),
    );
  }
}
