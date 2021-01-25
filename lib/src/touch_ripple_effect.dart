import 'package:flutter/material.dart';

class TouchRippleEffect extends StatefulWidget {
  /// [child] child widget
  /// [rippleColor] touch ripple color of widget
  /// background color [backgroundColor] of widget
  /// if you have border of child widget then you should apply [borderRadius]
  /// [rippleDuration] animation duration
  final Widget child;
  final Color rippleColor;
  final Color backgroundColor;
  final BorderRadius borderRadius;
  final Duration rippleDuration;

  TouchRippleEffect({
    Key key, this.child, this.backgroundColor, 
    this.rippleColor, this.borderRadius, this.rippleDuration,

    }) : super(key: key);

  @override
  _TouchRippleEffectState createState() => _TouchRippleEffectState();
}

class _TouchRippleEffectState extends State<TouchRippleEffect> with SingleTickerProviderStateMixin {
  Offset _tapOffset = Offset(0,0);
  GlobalKey _globalKey = GlobalKey();
  Animation<double> _anim;
  AnimationController _animationController;



  double _mWidth = 0;
  double _mHeight = 0;
  Tween<double> _tweenAnim;

  double _animRadiusValue = 0;
   

  @override
  void initState() { 
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.rippleDuration == null ? Duration(milliseconds: 300): widget.rippleDuration 
    );
    _animationController.addListener(_update);
    
  }

  void _update(){
    setState(() {
        _animRadiusValue = _anim.value;
      });
      _animStatus();
  }

  void _animStatus(){
    if(_anim.status ==AnimationStatus.completed){
      setState(() {
        _animRadiusValue = 0;
      });
      _animationController.stop();
    }
  }

  @override
  void dispose() { 
    _animationController.dispose();
    super.dispose();
  }

  void _animate(){
    _tweenAnim = Tween(begin: 0, end: _mWidth+_mHeight);
    _anim =_tweenAnim.animate(_animationController);
    _animationController.reset();
     _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (details){
        var lp = details.localPosition;
        setState(() {
          _tapOffset = Offset(lp.dx, lp.dy);
        });
        var size = _globalKey.currentContext.size;
        _mWidth = size.width;
        _mHeight = size.height;
        _animate();
      },
      child: Container(
        key: _globalKey,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: widget.backgroundColor == null ? Colors.transparent: widget.backgroundColor,
          borderRadius: widget.borderRadius,
        ),
        child: Stack(
          children: [
            widget.child,
            Opacity(
              opacity: 0.3,
              child: CustomPaint(
                painter: RipplePainer(offset: _tapOffset, circleRadius: _animRadiusValue, fillColor: widget.rippleColor),
              ),
              )
          ],
        ),
      ),
      
    );
    
  }
}


class RipplePainer extends CustomPainter{
  final Offset offset;
  final double circleRadius;
  final Color fillColor;
  RipplePainer({this.offset, this.circleRadius, this.fillColor});

  @override
  void paint(Canvas canvas, Size size) {

      var paint = Paint()
      ..color = this.fillColor == null ? throw Exception("rippleColor of TouchRippleEffect == null") :this.fillColor 
      ..isAntiAlias = true;
      canvas.drawCircle(offset, circleRadius, paint);
    }
  
    @override
    bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}