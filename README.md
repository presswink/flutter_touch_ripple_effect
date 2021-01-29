# touch_ripple_effect

A new flutter package for any flutter widgets to add touch ripple effect and touch feedback.

## find package on [pub.dev](https://pub.dev/packages?q=touch_ripple_effect)

## demo of TouchRippleEffect Widget in search icon Button

![TouchRippleEffect](./screenshots/touch_ripple_effect.gif)

## demo of TouchFeedback Widget in Hit me button

![TouchRippleEffect](./screenshots/touch_feedback.gif)

## Getting Started

1 ) open pubspec.yaml file in project dir and write [touch_ripple_effect:](https://github.com/Adityapanther/flutter-touch-ripple-effect) at below cupertino_icons.

pubsec.yaml:

```bash
touch_ripple_effect: 2.1.3
```

2 ) open command prompt in project dir and run

Command Line:

```bash
flutter pub get
```

## properties of TouchRippleEffect Widget

properies | details| default value|required|
---|---|---|---
width| TouchRippleEffect widget width size| null| false
height| TouchRippleEffect widget height size| null| false
child| child widget in which you want to apply Touch Ripple effect| null| true
rippleColor| color thats you want to see as a ripple effect| null | true
onTap| Listen onTap or click of child Widget| null| false
rippleDuration| how much time take to display ripple effect| 300 milliseconds| false
backgroundColor| background color of TouchRippleEffect| transparent| false
borderRadius|border radius of TouchRippleEffect widget| null| false

## properties of TouchFeedback Widget

properies | details| default value|required|
---|---|---|---
child| child widget in which you want to apply Touch Ripple effect| null| true
rippleColor| color thats you want to see as a ripple effect| null | true
onTap| Listen onTap or click of child Widget| null| false
feedbackDuration| how much time take to display ripple effect| 300 milliseconds| false
backgroundColor| background color of TouchRippleEffect| transparent| false
borderRadius|border radius of TouchRippleEffect widget| null| false
