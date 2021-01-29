import 'package:flutter/material.dart';

class TouchRippleEffect extends StatefulWidget {
  /// child widget [child]
  final Widget child;

  /// touch effect color of widget [rippleColor]
  final Color rippleColor;

  /// TouchRippleEffect widget background color [backgroundColor]
  final Color backgroundColor;

  /// if you have border of child widget then you should apply [borderRadius]
  final BorderRadius borderRadius;

  /// animation duration of touch effect. [rippleDuration]
  final Duration rippleDuration;

  /// user click or tap handle [onTap].
  final void Function() onTap;

  /// TouchRippleEffect widget width size [width]
  final double width;

  /// TouchRippleEffect widget height size [height]
  final double height;

  TouchRippleEffect({
    Key key,
    this.child,
    this.backgroundColor,
    this.onTap,
    this.width,
    this.height,
    this.rippleColor,
    this.borderRadius,
    this.rippleDuration,
  }) : super(key: key);

  @override
  _TouchRippleEffectState createState() => _TouchRippleEffectState();
}

class _TouchRippleEffectState extends State<TouchRippleEffect>
    with SingleTickerProviderStateMixin {
  // by default offset will be 0,0
  // it will be set when user tap on widget
  Offset _tapOffset = Offset(0, 0);

  // globalKey variable decleared
  GlobalKey _globalKey = GlobalKey();

  // animation global variable decleared and
  // type cast is double
  Animation<double> _anim;

  // animation controller global variable decleared
  AnimationController _animationController;

  /// width of user child widget
  double _mWidth = 0;

  // height of user child widget
  double _mHeight = 0;

  // tween animation global variable decleared and
  // type cast is double
  Tween<double> _tweenAnim;

  // animation count of Tween anim.
  // by default value is 0.
  double _animRadiusValue = 0;

  Duration _defaultDuration = Duration(milliseconds: 300);

  @override
  void initState() {
    super.initState();
    // animation controller initialized
    _animationController = AnimationController(
        vsync: this,
        duration: widget.rippleDuration == null
            ? _defaultDuration
            : widget.rippleDuration);
    // animation controller listener added or iitialized
    _animationController.addListener(_update);
  }

  // update animation when started

  void _update() {
    setState(() {
      // [_anim.value] setting to [_animRadiusValue] global variable
      _animRadiusValue = _anim.value;
    });
    // animation status function calling
    _animStatus();
  }

  // checking animation status is completed
  void _animStatus() {
    if (_anim.status == AnimationStatus.completed) {
      setState(() {
        _animRadiusValue = 0;
      });
      // stoping animation after completed
      _animationController.stop();
    }
  }

  @override
  void dispose() {
    // disposing [_animationController] when parent exist of close
    _animationController.dispose();
    super.dispose();
  }

  // animation initialize reset and start
  void _animate() {
    // [Tween] animation initialize to global variable
    _tweenAnim = Tween(
        begin: 0,
        end: widget.width == null
            ? _mWidth
            : widget.width * 2 + widget.height == null
                ? _mHeight
                : widget.height * 2);

    // adding [_animationController] to [_tweenanim] to animate
    _anim = _tweenAnim.animate(_animationController);

    // resetting [_animationController] before start
    _animationController.reset();

    // starting [_animationController] to start animation
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // delayed onTap till ripple effect
        Future.delayed(
            widget.rippleDuration == null
                ? _defaultDuration
                : widget.rippleDuration, () {
          widget.onTap();
        });
      },
      onTapDown: (details) {
        // getting tap [localPostion] of user
        var lp = details.localPosition;
        setState(() {
          /// setting [Offset] of user tap to [_tapOffset] global variable
          _tapOffset = Offset(lp.dx, lp.dy);
        });

        // getting [size] of child widget
        var size = _globalKey.currentContext.size;

        // child widget [width] initialize to [_width] global variable
        _mWidth = size.width;

        // child widget [height] initialize to [_height] global variable
        _mHeight = size.height;

        // starting animation
        _animate();
      },
      child: Container(
        width: widget.width,
        height: widget.height,

        // added globalKey for getting child widget size
        key: _globalKey,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          // when color == null then color will be transpatent otherwise color will be backgroundColor
          color: widget.backgroundColor == null
              ? Colors.transparent
              : widget.backgroundColor,

          // boderRadius of container if user passed
          borderRadius: widget.borderRadius,
        ),
        child: Stack(
          children: [
            // added child widget of user
            widget.child,
            Opacity(
              opacity: 0.3,
              child: CustomPaint(
                // ripplePainter is CustomPainer for circular ripple draw
                painter: RipplePainer(
                    offset: _tapOffset,
                    circleRadius: _animRadiusValue,
                    fillColor: widget.rippleColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class RipplePainer extends CustomPainter {
  // user tap locations [Offset]
  final Offset offset;

  // radius of circle which will be ripple color size [circleRadius]
  final double circleRadius;

  // fill color of ripple [fillColor]
  final Color fillColor;
  RipplePainer({this.offset, this.circleRadius, this.fillColor});

  @override
  void paint(Canvas canvas, Size size) {
    // throw an [rippleColor == null error] if ripple color is null
    var paint = Paint()
      ..color = this.fillColor == null
          ? throw Exception("rippleColor of TouchRippleEffect == null")
          : this.fillColor
      ..isAntiAlias = true;

    // drawing canvas based on user click offset,radius and paint
    canvas.drawCircle(offset, circleRadius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
