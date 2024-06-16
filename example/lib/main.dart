import 'package:flutter/material.dart';
import 'package:touch_ripple_effect/touch_ripple_effect.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _helloRadius = BorderRadius.circular(5);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          textDirection: TextDirection.ltr,
          children: [
            // touch ripple effect implemented

            TouchRippleEffect(
                borderRadius: _helloRadius,
                rippleColor: Colors.white60,
                onTap: () {
                  print("adi !");
                },
                child: Container(
                  width: 110,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.pink, borderRadius: _helloRadius),
                  child: Text("On Click", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),),
                )),

            // longPress button

            TouchRippleEffect(
                borderRadius: _helloRadius,
                rippleColor: Colors.white60,
                onLongPress: () {
                  print("adi !");
                },
                child: Container(
                  width: 110,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.pink, borderRadius: _helloRadius),
                  child: Text("LongPress", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),),
                )
            ),

            // longPress button

            TouchRippleEffect(
              shadow: [
                BoxShadow(color: Colors.grey, blurRadius: 3, offset: Offset(3, 3))
              ],
                borderRadius: _helloRadius,
                rippleColor: Colors.white60,
                onTap: () {
                  print("adi !");
                },
                child: Container(
                  width: 110,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.pink, borderRadius: _helloRadius),
                  child: Text("shadow", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),),
                )
            ),

            // touch Feedback effect implemented.
            TouchFeedback(
              onTap: () {
                print(" I am Aditya");
              },
              rippleColor: Colors.blue[200],
              child: Container(
                  width: 120,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text("Hit me !",
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold))),
            )
          ],
        ),
      )),
    );
  }
}
