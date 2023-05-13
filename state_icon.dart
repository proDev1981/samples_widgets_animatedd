import 'package:flutter/material.dart';
import 'dart:math';

class IconHover extends StatefulWidget{

  static const _currentColor = Colors.black;
  static const _currentSize = 25.0;
  static const _currentRotation = 0.0;

  IconHover(this.icon,
  {
    super.key,
    this.duration = const Duration(milliseconds: 300),
    // current atttibutes
    this.color = _currentColor, 
    this.size = _currentSize, 
    this.rotation = _currentRotation,
    this.fill, 
    this.weight, 
    this.grade, 
    this.opticalSize, 
    this.shadow,
    // hover attributes 
    this.colorHover = _currentColor, 
    this.sizeHover = _currentSize, 
    this.rotationHover = _currentRotation,
    this.fillHover, 
    this.weightHover, 
    this.gradeHover, 
    this.opticalSizeHover, 
    this.shadowHover,
    });

  final IconData icon;
  // colors
  Color? color;
  Color? colorHover;
  // sizes
  double? size;
  double? sizeHover;
  // filles
  double? fill;
  double? fillHover;
  // weight
  double? weight;
  double? weightHover;
  // grades
  double? grade;
  double? gradeHover;
  // opticalSizes
  double? opticalSize;
  double? opticalSizeHover;
  // shadows
  List<Shadow>? shadow;
  List<Shadow>? shadowHover;
  // rotation
  double? rotation;
  double? rotationHover;
  // animation
  Duration? duration;


  @override
  State<IconHover> createState() => _IconHoverState();
}

class _IconHoverState extends State<IconHover> with TickerProviderStateMixin {

  bool isHover = true;
  late AnimationController _controller;
  late Animation _color;
  late Animation _size;
  late Animation _rotation;

  // transform angle to double
  double _fromAngle(double? angle){
    return angle!*(2*pi)/360;
  }
  // get scale of size 
  double _getMaxScale(){
    return widget.sizeHover!/widget.size!;
  }

  @override
  void initState() {
    // animation controller
    _controller = AnimationController(vsync: this, duration: widget.duration );

    // animations
    _color = ColorTween(
      begin: widget.color,
      end: widget.colorHover,
    ).animate(_controller);

    _size = Tween<double>(
      begin: 1,
      end: _getMaxScale()
    ).animate(_controller);

    _rotation = Tween<double>(
      begin: _fromAngle(widget.rotation),
      end: _fromAngle(widget.rotationHover)
    ).animate(_controller);

    super.initState();
  }

  @override
  void dispose() {
    // dispose animation controller
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onExit: (event){ 
        // init animation mode reverse
        _controller.reverse(from: 1);
        },
      onEnter: (event){ 
        // init animation
        _controller.forward(from: 0);
        },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context,_) {
          return Transform.rotate(
            angle: _rotation.value,
            alignment: Alignment.center,
            child: Transform.scale(
              scale: _size.value,
              child: Icon(
                widget.icon, 
                color:        _color.value,
                grade:        (isHover)? widget.gradeHover : widget.grade,
                fill:         (isHover)? widget.fillHover : widget.fill,
                opticalSize:  (isHover)? widget.opticalSizeHover : widget.opticalSize,
                shadows:      (isHover)? widget.shadowHover : widget.shadow
                ),
            ),
          );
        }
      )
      );
  }
}