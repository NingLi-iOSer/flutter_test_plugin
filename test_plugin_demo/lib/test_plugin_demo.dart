import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TestPluginDemo {
  static const BasicMessageChannel _getImageChannel = const BasicMessageChannel('com.test/get_image', StandardMessageCodec());

  static getImage(handler(Uint8List imageData)) {
    _getImageChannel.setMessageHandler((value) async {
      Uint8List imageDataList = base64Decode(value);
      handler(imageDataList);
    });
  }

  static Widget testUiView(String image) {
    return UiKitView(
      viewType: 'com.test/test_view',
      creationParams: {'image': image},
      creationParamsCodec: const StandardMessageCodec(),
    );
  }
}
