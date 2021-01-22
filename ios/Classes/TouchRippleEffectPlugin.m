#import "TouchRippleEffectPlugin.h"
#if __has_include(<touch_ripple_effect/touch_ripple_effect-Swift.h>)
#import <touch_ripple_effect/touch_ripple_effect-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "touch_ripple_effect-Swift.h"
#endif

@implementation TouchRippleEffectPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftTouchRippleEffectPlugin registerWithRegistrar:registrar];
}
@end
