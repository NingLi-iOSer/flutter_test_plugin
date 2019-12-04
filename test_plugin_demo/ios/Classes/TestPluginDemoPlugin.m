#import "TestPluginDemoPlugin.h"
#import <test_plugin_demo/test_plugin_demo-Swift.h>

@implementation TestPluginDemoPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftTestPluginDemoPlugin registerWithRegistrar:registrar];
}
@end
