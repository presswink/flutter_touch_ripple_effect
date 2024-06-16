import 'package:flutter/material.dart';

class TouchRippleEffect extends StatefulWidget {
  /// child widget [child]
  final Widget? child;

  /// touch effect color of widget [rippleColor]
  final Color? rippleColor;

  /// TouchRippleEffect widget background color [backgroundColor]
  final Color? backgroundColor;

  /// if you have border of child widget then you should apply [borderRadius]
  final BorderRadius? borderRadius;

  /// animation duration of touch effect. [rippleDuration]
  final Duration? rippleDuration;

  /// user click or tap handle [onTap].
  final void Function()? onTap;

  /// Await the animation to complete on [onTap]. Defaults to true.
  final bool awaitAnimation;

  /// TouchRippleEffect widget width size [width]
  final double? width;

  /// TouchRippleEffect widget height size [height]
  final double? height;

  /// [shadow] will add shadow effect to the parent widget
  final List<BoxShadow>? shadow;

  /// [onLongPress] will handle widget long press touch
  final void Function()? onLongPress;

  TouchRippleEffect({
    Key? key,
    this.child,
    this.backgroundColor,
    this.onTap,
    this.awaitAnimation = true,
    this.width,
    this.height,
    this.rippleColor,
    this.borderRadius,
    this.rippleDuration,
    this.shadow,
    this.onLongPress,
  }) : super(key: key);

  @override
  _TouchRippleEffectState createState() => _TouchRippleEffectState();
}

class _TouchRippleEffectState extends State<TouchRippleEffect>
    with
        SingleTickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<TouchRippleEffect> {
  // by default offset will be 0,0
  // it will be set when user tap on widget
  Offset _tapOffset = Offset(0, 0);

  // globalKey variable declared
  GlobalKey _globalKey = GlobalKey();

  // animation global variable declared and
  // type cast is double
  Animation<double>? _anim;

  // animation controller global variable declared
  late AnimationController _animationController;

  bool _isAnimationCompleted = true;

  /// width of user child widget
  double _mWidth = 0;

  // tween animation global variable declared and
  // type cast is double
  late Tween<double> _tweenAnim;

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
    // animation controller listener added or initialized
    _animationController.addListener(_update);
  }

  // update animation when started

  void _update() {
    setState(() {
      // [_anim.value] setting to [_animRadiusValue] global variable
      _animRadiusValue = _anim!.value;
    });
    // animation status function calling
    _animStatus();
  }

  // checking animation status is completed
  void _animStatus() {
    if (_anim!.status == AnimationStatus.completed) {
      setState(() {
        _animRadiusValue = 0;
      });
      // stopping animation after completed
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
    _tweenAnim = Tween(begin: 0, end: widget.width ?? _mWidth);

    // adding [_animationController] to [_tweenAnim] to animate
    _anim = _tweenAnim.animate(_animationController);

    // resetting [_animationController] before start
    _animationController.reset();

    // Adding [_isAnimationCompleted] flag
    _isAnimationCompleted = false;
    updateKeepAlive();

    // starting [_animationController] to start animation
    _animationController.forward().whenCompleteOrCancel(() {
      _isAnimationCompleted = true;
      updateKeepAlive();
    });
  }

  @override
  bool get wantKeepAlive => !_isAnimationCompleted;

  @override
  Widget build(BuildContext context) {
    super.build(context); // See AutomaticKeepAliveClientMixin.

    return GestureDetector(
      onTap: () {
       if(widget.onLongPress == null){
         if (!widget.awaitAnimation) {
           widget.onTap!();
         }else {
           // delayed onTap till ripple effect
           Future.delayed(widget.rippleDuration ?? _defaultDuration, () {
                 widget.onTap!();
               });
         }
       }
      },
      onTapDown: (details) {
        // getting tap [localPosition] of user
        var lp = details.localPosition;
        setState(() {
          /// setting [Offset] of user tap to [_tapOffset] global variable
          _tapOffset = Offset(lp.dx, lp.dy);
        });

        // getting [size] of child widget
        var size = _globalKey.currentContext!.size!;

        // child widget [width] initialize to [_width] global variable
        _mWidth = size.width;

        // starting animation
        if(widget.onLongPress == null){
          _animate();
        }

      },
      onLongPressDown: (details){
        var lp = details.localPosition;
        setState(() {
          /// setting [Offset] of user tap to [_tapOffset] global variable
          _tapOffset = Offset(lp.dx, lp.dy);
        });

        // getting [size] of child widget
        var size = _globalKey.currentContext!.size!;

        // child widget [width] initialize to [_width] global variable
        _mWidth = size.width;
      },
      onLongPressUp: (){
        // starting animation
        if(widget.onTap == null){
          _animate();
        }
      },
      onLongPress: (){
        if(widget.onTap == null){
          if (!widget.awaitAnimation) {
            widget.onLongPress!();
          }else {
            // delayed onTap till ripple effect
            Future.delayed(
                widget.rippleDuration ?? _defaultDuration,
                    () {
                  widget.onLongPress!();
                });
          }
        }
      },
      child: Container(
        width: widget.width,
        height: widget.height,

        // added globalKey for getting child widget size
        key: _globalKey,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          // when color == null then color will be transparent otherwise color will be backgroundColor
          color: widget.backgroundColor == null
              ? Colors.transparent
              : widget.backgroundColor,

          // borderRadius of container if user passed
          borderRadius: widget.borderRadius,
        ),
        child: Stack(
          textDirection: TextDirection.ltr,
          children: [
            // added child widget of user
            widget.child!,
            Opacity(
              opacity: 0.3,
              child: CustomPaint(
                // ripplePainter is CustomPainter for circular ripple draw
                painter: RipplePainter(
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

class RipplePainter extends CustomPainter {
  // user tap locations [Offset]
  final Offset? offset;

  // radius of circle which will be ripple color size [circleRadius]
  final double? circleRadius;

  // fill color of ripple [fillColor]
  final Color? fillColor;
  RipplePainter({this.offset, this.circleRadius, this.fillColor});

  @override
  void paint(Canvas canvas, Size size) {
    // throw an [rippleColor == null error] if ripple color is null
    var paint = Paint()
      ..color = this.fillColor == null
          ? throw Exception("rippleColor of TouchRippleEffect == null")
          : this.fillColor!
      ..isAntiAlias = true;

    // drawing canvas based on user click offset,radius and paint
    canvas.drawCircle(offset!, circleRadius!, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
