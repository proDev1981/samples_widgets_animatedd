import 'dart:async';

import 'package:flutter/material.dart';

class Fade extends StatefulWidget{

  static const _defaultDuration = Duration(milliseconds: 300);

  Fade(
    {
      this.duration = _defaultDuration, 
      this.delay = _defaultDuration,
      this.child,
      super.key
    }):directionOut = false;

  Fade.out(
    {
      this.duration = _defaultDuration, 
      this.delay = _defaultDuration,
      this.child,
      super.key
    }):directionOut = true;

  bool directionOut;
  final Duration duration;
  final Duration delay;
  final Widget? child;

  @override
  State<Fade> createState() => _FadeState();
}

class _FadeState extends State<Fade> 
  with TickerProviderStateMixin{

    late final AnimationController controller ;
    late final Animation fadeIn;
  
  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: widget.duration);
    fadeIn = Tween(
      begin: 0.0,
      end: 1.0
    ).animate(controller);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Timer(widget.delay, ()=> controller.forward());
    
    return AnimatedBuilder(
      animation: fadeIn,
      builder: (context,_){
        return Opacity(
          opacity: widget.directionOut ? 1.0 - fadeIn.value : fadeIn.value,
          child:widget.child
          );
      },
      );
  }
}