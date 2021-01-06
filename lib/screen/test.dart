import 'package:appcheck/bloc/qr_bloc.dart';
import 'package:appcheck/model/qr_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TestHome extends StatefulWidget {
  @override
  _TestHomeState createState() => _TestHomeState();
}

class _TestHomeState extends State<TestHome> {
  
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    var bloc = Provider.of<QrBloc>(context);
    bloc.initData();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<QrBloc>(
      builder: (context, bloc, child) => StreamBuilder<List<QRdata>>(
        stream: bloc.qrList,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
              return ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 50,
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
                                '   ${snapshot.data[index].content}',
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
                  });
              case ConnectionState.waiting:
                  return Center(
                child: Container(
                  height: 70,
                  width: 70,
                  child: Text('Vui lòng quét mã.', style: TextStyle(fontSize: 20),),
                ),
              );
            case ConnectionState.none:
            default:
              return Center(
                child: Container(
                  height: 70,
                  width: 70,
                  child: CircularProgressIndicator(),
                ),
              );
          }
        },
      ),
    );
  }
}
