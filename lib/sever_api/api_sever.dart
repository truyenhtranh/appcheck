import 'package:flutter/material.dart';
import 'package:http/http.dart';

_makePostRequest() async {
  // cài đặt tham số POST request
  String url = 'http://testqrcode.nanoweb.vn/api/app/code/get-code';

  // Map<String, String> headers = {"Content-type": "application/json"};

  String json = '{"code": "2342546546353", "latlng": "21,103", "imei": "1234555"}';
  // tạo POST request
  Response response = await post(url, body: json);
  // kiểm tra status code của kết quả response
  int statusCode = response.statusCode;
  // API này trả về id của item mới được add trong body
  String body = response.body;
  print(body);
  // {
  //   "title": "Hello",
  //   "body": "body text",
  //   "userId": 1,
  //   "id": 101
  // }
}