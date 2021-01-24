import 'package:flutter/material.dart';

class TouchRippleEffect extends StatefulWidget {
  final Widget child;
  final Color rippleColor;
  final Color backgroundColor;
  final BorderRadius borderRadius;
  final Duration duration;
  final void Function() onTap;
  TouchRippleEffect({
    this.child, this.rippleColor, this.borderRadius,
    this.backgroundColor, this.duration,
    this.onTap
    });

  @override
  _TouchRippleEffectState createState() => _TouchRippleEffectState();
}

class _TouchRippleEffectState extends State<TouchRippleEffect> {
  GlobalKey _globalKey = GlobalKey();
  Widget _rippleWidget;
  double _dx;
  double _dy;

  double _mWidth;
  double _mHeight;

  double _animWidth;
  double _animHeight;

  Duration _defaultDuration = Duration(milliseconds: 200);

  @override
  void initState() { 
    super.initState();

  }

  void _generateRipple(){
    
    setState(() {
      _rippleWidget = Opacity(
        opacity: 0.2,
        child: AnimatedContainer(
          width: _animWidth == _mWidth? 10: _animWidth,
          height: _animWidth == _mHeight ? 10: _animHeight,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: widget.rippleColor, borderRadius: BorderRadius.circular(5)),
          duration: widget.duration != null ? widget.duration: _defaultDuration,
          curve: Curves.easeInQuint,
          ),
      );
    });
    milisecons();
    _dx= 0;
    _dy =0;
  }

  void milisecons(){
    setState(() {
      for(double i = 0; _mWidth> i; i++){
         _animWidth = i;
      }
      for(double i = 0; _mHeight > i; i++){
        _animHeight = i;
      }

      });
  }

  void _setChildSize(){
    setState(() {
      _mWidth = _globalKey.currentContext.size.width;
      _mHeight = _globalKey.currentContext.size.height;
      _animWidth = _mWidth;
      _animHeight = _mHeight;
    });
  }

  void _timeOut(){
    Future.delayed(
      widget.duration != null ? widget.duration : _defaultDuration,
      (){
        setState(() {
          _rippleWidget = null;
        });
      }
    );
  }

 

  @override
  Widget build(BuildContext context) {
    
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (taped){
        _dx = taped.localPosition.dx;
        _dy = taped.localPosition.dy;
        _setChildSize();
        _generateRipple();
        _timeOut();
      },
      child: Container(
        key: _globalKey,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: widget.borderRadius,
          color: widget.backgroundColor == null ? Colors.transparent: widget.backgroundColor,
        ),
         child: Stack(
           clipBehavior: Clip.antiAlias,
           children: [
             widget.child == null ? throw Exception("touch ripple effect Child == null"): widget.child,
             Container(
               width: _mWidth == null ? 10: _mWidth,
               height: _mHeight== null ? 10: _mHeight,
               color: Colors.transparent,
               padding: EdgeInsets.fromLTRB(_dx == null ? 0:_dx, _dy == null ?0 : _dy, 0, 0),
               child: _rippleWidget,
               ),
           ],
         ),
      ),
    );
  }
}
