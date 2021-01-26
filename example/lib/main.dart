import 'package:flutter/material.dart';
import 'package:touch_ripple_effect/touch_ripple_effect.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: ListView(
            children: [
              TouchRippleEffect(
                rippleDuration: Duration(milliseconds: 300),
                backgroundColor: Colors.blue,
                rippleColor: Colors.white,
                child: Container(width: 200, height: 120, color: Colors.yellow, child: Text("hello"),),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

