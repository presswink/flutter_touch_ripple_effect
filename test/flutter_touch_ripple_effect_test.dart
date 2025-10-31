import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:touch_ripple_effect/touch_ripple_effect.dart';

void main() {
  testWidgets('testing TouchRippleEffect widget', (tester) async {
    await tester.pumpWidget(MaterialApp(home: TouchRippleEffect(
      rippleColor: Colors.yellow,
      child: SizedBox(width: 400, height: 400, child: Icon(Icons.add), ),
    ),));
    expect(find.byIcon(Icons.add), findsOneWidget);
  });

  testWidgets('testing TouchFeedback widget', (tester) async {
    await tester.pumpWidget(MaterialApp(home: TouchFeedback(child: SizedBox(width: 400, height: 400, child: Icon(Icons.remove),),),));
    expect(find.byIcon(Icons.remove), findsOneWidget);
  });
}


