import Flutter
import UIKit

public class SwiftTestPluginDemoPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "com.test/test", binaryMessenger: registrar.messenger())
        let instance = SwiftTestPluginDemoPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
        
        let factory = TestViewFactory(messenger: registrar.messenger())
        registrar.register(factory, withId: "com.test/test_view")
    }
}
