import 'dart:async';

import 'package:flutter/material.dart';
import 'package:animation_samples/custom_widgets/animated/animations.dart';

class ButtonCheckboxAnimated extends StatefulWidget{

  ButtonCheckboxAnimated(
    {
      required this.child,
      required this.icon,
      this.resolvedWidget = const Icon(Icons.check_circle, color: Colors.greenAccent),
      this.rejectedWidget = const Icon(Icons.error_sharp, color: Colors.redAccent),
      this.color = Colors.indigo,
      this.colorProgressIndicator = Colors.white,
      this.height = 50,
      this.width = 150,
      this.elevation = 0,
      this.decoration,
      this.mainAxisAlignment = MainAxisAlignment.center,
      this.separation = 10,
      this.onTap,
      super.key
    }): reposedWidget = icon {

      onTap       = onTap ?? () => true;
      decoration  = decoration ?? BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color,
        boxShadow: [ BoxShadow(
          blurRadius: elevation,
          color: Colors.grey
        ) ],
      );
    }

  Widget reposedWidget;
  Widget resolvedWidget;
  Widget rejectedWidget;
  Widget child;
  Widget icon;
  Color color;
  Color colorProgressIndicator;
  double width;
  double height;
  double elevation;
  Decoration? decoration;
  double separation;
  MainAxisAlignment mainAxisAlignment;
  bool Function()? onTap;

  @override
  State<ButtonCheckboxAnimated> createState() => _ButtonCheckboxAnimatedState();
}

class _ButtonCheckboxAnimatedState extends State<ButtonCheckboxAnimated> {

    Widget inProgress = const Icon(Icons.person);

  void changeInProgress(){
    widget.icon = SizedBox(
      width: 20,
      height: 20,
      child: CircularProgressIndicator(
        color: widget.colorProgressIndicator,
        strokeWidth: 2.0,
        ),
      );
    setState((){});
  }
  void changeInResolved(){
    widget.icon = Stack(
      children: [
        SizeBound.out(
          delay: const Duration(seconds: 1),
          duration: const Duration(milliseconds: 300),
          child:widget.resolvedWidget
        ),
        SizeBound(
          delay: const Duration(seconds: 1),
          duration: const Duration(milliseconds: 500),
          child:widget.reposedWidget
        )
      ],
    );
    setState(() {});
  }
  void changeInReject(){
    widget.icon = Stack(
      children: [
        SizeBound.out(
          delay: const Duration(seconds: 1),
          duration: const Duration(seconds: 2),
          child:widget.rejectedWidget
        ),
        SizeBound(
          delay: const Duration(seconds: 1),
          duration: const Duration(seconds: 2),
          child:widget.reposedWidget
        )
      ],
    );
    setState(() {}); 
  }
  void changeInRepose(){
    widget.icon = widget.reposedWidget;
    setState(() {});
  }
  Future<bool> callOnTap()async{
    return widget.onTap!();
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: (){
        changeInProgress();
        Timer(const Duration(seconds: 1),()async{
          bool status = await callOnTap();
          status ? changeInResolved() : changeInReject();
        });
      },
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: widget.decoration,
        child:Row(
          mainAxisAlignment: widget.mainAxisAlignment,
          children:[
            widget.icon,
            SizedBox(width: widget.separation),
            widget.child,
          ]
        )
      ),
    );
  }
}