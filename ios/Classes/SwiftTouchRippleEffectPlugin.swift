import Flutter
import UIKit

public class SwiftTouchRippleEffectPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "touch_ripple_effect", binaryMessenger: registrar.messenger())
    let instance = SwiftTouchRippleEffectPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
