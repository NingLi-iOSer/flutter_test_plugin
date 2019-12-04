import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:test_plugin_demo/test_plugin_demo.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Future _future;

  Uint8List _imageDataList;

  @override
  void initState() {
    super.initState();
    TestPluginDemo.getImage((imageData) {
      setState(() {
        _imageDataList = imageData;
      });
    });

    _future = _getImageData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              FutureBuilder(
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      width: 300,
                      height: 300,
                      padding: EdgeInsets.all(10),
                      child: TestPluginDemo.testUiView(snapshot.data),
                    );
                  } else {
                    return Container();
                  }
                },
                future: _future,
              ),
              _imageItem(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _imageItem() {
    if (_imageDataList != null) {
      return Container(
        padding: EdgeInsets.all(20),
        child: Image.memory(_imageDataList),
      );
    } else {
      return Container();
    }
  }

  Future<String> _getImageData() async {
    ByteData imageData = await rootBundle.load('images/image.png');
    String imageBase64 = base64Encode(imageData.buffer.asUint8List());
    return imageBase64;
  }
}

