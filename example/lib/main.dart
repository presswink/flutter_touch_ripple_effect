import 'package:flutter/material.dart';
import 'package:touch_ripple_effect/touch_ripple_effect.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  @override
  void initState() {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// touch ripple effect implimented
              TouchRippleEffect(
                rippleColor: Colors.white60,
                child: IconButton(iconSize: 24.0, icon: Icon(Icons.search,),color: Colors.pink, onPressed: null),
              ),
              TouchFeedback(
                rippleColor: Colors.blue[200],
                child: Container(
                  width: 80,
                  height: 40, 
                  alignment: Alignment.centerLeft, 
                  color: Colors.yellow, 
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),), 
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
