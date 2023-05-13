import 'package:flutter/material.dart' as material;

class Container extends material.StatelessWidget{

  Container();

  material.Widget? _child;
  material.EdgeInsetsGeometry? _padding;
  material.EdgeInsetsGeometry? _margin;
  material.AlignmentGeometry? _alignment;
  material.Color? _color;
  List<material.BoxShadow>? _shadow;
  material.BorderRadius? _borderRadius;
  material.Size? _size;

  Container padding(material.EdgeInsetsGeometry padding){
    _padding = padding;
    return this;
  }

  Container margin(material.EdgeInsetsGeometry margin){
    _margin = margin;
    return this;
  }

  Container alignment(material.AlignmentGeometry alignment){
    _alignment = alignment;
    return this;
  }

  Container child(material.Widget child){
    _child = child;
    return this;
  }

  Container color(material.Color color){
    _color = color;
    return this;
  }

  Container shadow(List<material.BoxShadow> shadow){
    _shadow = shadow;    
    return this;
  }

  Container borderRadius(material.BorderRadius borderRadius){
    _borderRadius = borderRadius;
    return this;
  }

  Container size(material.Size size){
    _size = size;
    return this;
  }

  @override
  material.Widget build(material.BuildContext context) {
    return material.Container(
      alignment: _alignment,
      width: _size?.width,
      height: _size?.height,
      decoration: material.BoxDecoration(
        color: _color,
        boxShadow: _shadow,
        borderRadius: _borderRadius,
        ),
      margin: _margin,
      padding: _padding,
      child: _child,
    );
  }
}