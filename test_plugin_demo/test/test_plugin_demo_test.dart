import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_plugin_demo/test_plugin_demo.dart';

void main() {
  const MethodChannel channel = MethodChannel('test_plugin_demo');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

}
