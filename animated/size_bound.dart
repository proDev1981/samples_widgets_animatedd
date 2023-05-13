import 'dart:async';

import 'package:flutter/material.dart';

class SizeBound extends StatefulWidget{

  static const _defaultDuration = Duration(milliseconds: 300);

  SizeBound(
    {
      this.duration = _defaultDuration, 
      this.delay = _defaultDuration,
      this.child,
      super.key
    }): directionOut = false;

  SizeBound.out(
    {
      this.duration = _defaultDuration, 
      this.delay = _defaultDuration,
      this.child,
      super.key
    }): directionOut = true;

  bool directionOut;
  final Duration duration;
  final Duration delay;
  final Widget? child;

  @override
  State<SizeBound> createState() => _SizeBoundState();
}

class _SizeBoundState extends State<SizeBound> 
  with TickerProviderStateMixin{

    late final AnimationController controller ;
    late final Animation sizeOut;
    late final Animation boundOut;
  
  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: widget.duration);
    boundOut = CurveTween(
      curve: const Interval(
        0.0, 
        1.0,
        curve: Curves.bounceOut
        )).animate(controller);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Timer(widget.delay, () => controller.forward());
    
    return AnimatedBuilder(
      animation: boundOut,
      builder: (context,_){
        return Transform.scale(
          scale: widget.directionOut ? 1.0 - boundOut.value : boundOut.value,
          child:widget.child
          );
      },
      );
  }
}