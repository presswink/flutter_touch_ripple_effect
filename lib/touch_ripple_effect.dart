
import 'dart:async';

import 'package:flutter/services.dart';

class TouchRippleEffect {
  static const MethodChannel _channel =
      const MethodChannel('touch_ripple_effect');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
