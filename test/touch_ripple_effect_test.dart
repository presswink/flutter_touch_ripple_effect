import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:touch_ripple_effect/touch_ripple_effect.dart';

void main() {
  const MethodChannel channel = MethodChannel('touch_ripple_effect');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

}
