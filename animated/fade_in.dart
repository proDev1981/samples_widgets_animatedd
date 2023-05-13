import 'package:flutter/material.dart';


class FadeIn extends StatefulWidget{

  static const _defaultDuration = Duration(milliseconds: 300);

  FadeIn.left(
    {
      this.duration = _defaultDuration,
      this.child,
      this.horizontal = 50.0,
      this.vertical = 0,
      super.key
    });

  FadeIn.right(
    {
      this.duration = _defaultDuration,
      this.child,
      this.horizontal = -50.0,
      this.vertical = 0,
      super.key
    });

  FadeIn.bottom(
    {
      this.duration = _defaultDuration,
      this.child,
      this.horizontal = 0,
      this.vertical = -50,
      super.key
    });

  FadeIn.top(
    {
      this.duration = _defaultDuration,
      this.child,
      this.horizontal = 0,
      this.vertical = 50,
      super.key
    });

  final Duration duration;
  final Widget? child;
  double horizontal;
  double vertical;


  @override
  State<FadeIn> createState() => _FadeInState();
}

class _FadeInState extends State<FadeIn> with TickerProviderStateMixin {

  late AnimationController controller;
  late Animation fade;
  late Animation horizontal;
  late Animation vertical;

  @override
  void initState() {
    controller = AnimationController(vsync: this,duration: widget.duration);
    fade = CurveTween(curve: const Interval(0.4, 1.0)).animate(controller);
    horizontal = CurveTween(curve: const Interval(0.0, 1.0)).animate(controller);
    vertical = CurveTween(curve: const Interval(0.0, 1.0)).animate(controller);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    controller.forward();


    return AnimatedBuilder(
      animation: controller, 
      builder: (context,_){

        return Transform.translate(
          offset: Offset(widget.horizontal * (horizontal.value - 1) , widget.vertical * (vertical.value -1 )),
          child: Opacity(
            opacity: fade.value,
            child: widget.child
            ),
          );
      },
      );
  }
}