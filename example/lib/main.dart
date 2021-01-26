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
                width: 200,
                height: 200,
                onTap: (){
                  print("hello ad! ");
                },
                backgroundColor: Colors.blue,
                rippleColor: Colors.pink,
                child: Container(width: 200, height: 120, color: Colors.yellow, child: Text("hello"),),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

