import 'package:flutter/material.dart';

class TouchRippleEffect extends StatefulWidget {
  final Widget child;
  final Color rippleColor;
  final Color backgroundColor;

  TouchRippleEffect({Key key, this.child, this.backgroundColor, this.rippleColor}) : super(key: key);

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

  double _valueSem = 0;
   

  @override
  void initState() { 
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300)
    );
    _animationController.addListener(_update);
    
  }

  void _update(){
    setState(() {
        _valueSem = _anim.value;
      });
      _animStatus();
  }

  void _animStatus(){
    if(_anim.status ==AnimationStatus.completed){
      setState(() {
        _valueSem = 0;
      });
      _animationController.stop();
    }
  }

  @override
  void dispose() { 
    _animationController.dispose();
    super.dispose();
  }

  void animate(){
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
        animate();
      },
      child: Container(
        key: _globalKey,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.transparent
        ),
        child: Stack(
          children: [
            widget.child,
            Opacity(
              opacity: 0.5,
              child: CustomPaint(
                painter: RipplePainer(offset: _tapOffset, circleRadius: _valueSem),
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
  RipplePainer({this.offset, this.circleRadius});
  @override
  void paint(Canvas canvas, Size size) {

      var paint = Paint()
      ..color = Colors.yellow
      ..isAntiAlias = true;
      print(circleRadius);
      canvas.drawCircle(offset, circleRadius, paint);
    }
  
    @override
    bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}