import 'package:flutter/material.dart';
import '../database/data_list_class.dart';

class MyBodyHome extends StatefulWidget {
  @override
  _MyBodyHomeState createState() => _MyBodyHomeState();
}

class _MyBodyHomeState extends State<MyBodyHome> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return (lvData.length > 0)
          ? ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: lvData.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.qr_code_scanner,
                            color: Colors.blue,
                          ),
                          Text(
                            '   ${lvData[index]}',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              })
          : Container(
              child: Center(
                child: Text(
                  'Bạn chưa quét gì cả. Hay thử làm gì đó đi.',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
            );
  }
}
