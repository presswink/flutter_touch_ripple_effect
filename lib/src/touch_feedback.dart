import 'package:flutter/material.dart';

class TouchFeedback extends StatefulWidget {

  /// [child] user child widget
  /// [rippleColor] touch ripple color of widget
  /// [backgroundColor] of widget container
  /// if you have border of child widget then you should apply [borderRadius]
  /// [feedbackDuration] will be animation duration.
  /// [onTap] is for user click or tap handle.

  final Widget child;
  final Color rippleColor;
  final Color backgroundColor;
  final BorderRadius borderRadius;
  final Duration feedbackDuration;
  final void Function() onTap;
  TouchFeedback({
    this.child, this.rippleColor, this.borderRadius,
    this.backgroundColor, this.feedbackDuration,
    this.onTap
    });

  @override
  _TouchFeedbackState createState() => _TouchFeedbackState();
}

class _TouchFeedbackState extends State<TouchFeedback> {
  /// private [_globalKey] global variable initialized
  GlobalKey _globalKey = GlobalKey();

  /// private [_rippleWidget] global variable initialized
  Widget _rippleWidget;

  /// user tap private [_dx]  x-axis global variable initalized
  double _dx;
   /// user tap private [_dy]  y-axis global variable initalized
  double _dy;

  double _mWidth;
  double _mHeight;

  double _animWidth;
  double _animHeight;

  /// private [_defaultDuration] duration of animation if user not assign
  Duration _defaultDuration = Duration(milliseconds: 200);

  void _generateRipple(){
    
    setState(() {
      _rippleWidget = Opacity(
        opacity: 0.2,
        child: AnimatedContainer(
          width: _animWidth == _mWidth? 10: _animWidth,
          height: _animWidth == _mHeight ? 10: _animHeight,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: widget.rippleColor, borderRadius: BorderRadius.circular(5)),
          duration: widget.feedbackDuration != null ? widget.feedbackDuration: _defaultDuration,
          curve: Curves.easeInQuint,
          ),
      );
    });
    milisecons();
    // resetting axis after animation
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
      /// sets child widget width to [_mWidth]
      _mWidth = _globalKey.currentContext.size.width;
       /// sets child widget Height to [_mHeight]
      _mHeight = _globalKey.currentContext.size.height;
      /// setting [_mWidth] and [_mHeight] to [_animWidth] and [_animHeight]
      _animWidth = _mWidth;
      _animHeight = _mHeight;
    });
  }

  /// hide rippleWidget when time-up

  void _timeOut(){
    Future.delayed(
      widget.feedbackDuration != null ? widget.feedbackDuration : _defaultDuration,
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
