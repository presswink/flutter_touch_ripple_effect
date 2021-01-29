import 'package:flutter/material.dart';
import 'package:touch_ripple_effect/touch_ripple_effect.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
MyApp({Key key}) : super(key: key);

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
            children: [
              /// touch ripple effect implimented
              
              TouchRippleEffect(
                borderRadius: _helloRadius,
                rippleColor: Colors.white60,
                onTap: (){
                  print("adi !");
                },
                child: Container(
                  width: 110, 
                  height: 50, 
                  alignment: Alignment.center, 
                  decoration: BoxDecoration(color: Colors.pink, borderRadius: _helloRadius),
                  child: IconButton(
                    iconSize: 24.0, 
                    icon: Icon(Icons.search,color: Colors.white, size: 36,), 
                    onPressed: null
                    ),)
              ),

              /// touch Feedback effect implimented.
              TouchFeedback(
                onTap: (){
                  print(" I am Aditya");
                },
                rippleColor: Colors.blue[200],
                child: Container(
                  width: 120,
                  height: 40, 
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: Colors.yellow, borderRadius: BorderRadius.circular(5),), 
                  child: Text(
                    "Hit me !", 
                    style: TextStyle(fontSize: 20, fontWeight:  FontWeight.bold)
                    )
                    ),
              )
            ],
          ),
        )
        ),
      );
  }
}

