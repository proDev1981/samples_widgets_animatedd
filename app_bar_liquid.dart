import 'package:flutter/material.dart';

class CustomBottonAnimatedBar extends StatefulWidget{

  CustomBottonAnimatedBar(
    {
      this.onTap,
      this.colorContainer = Colors.blue,
      this.colorStrokeSelected = Colors.white,
      this.colorForegraundSelected = Colors.white,
      this.colorCurrentForegraund,
      this.colorBackgroundSelected = Colors.blueAccent,
      this.scale = 1.5,
      this.elevationSelected = 15,
      required this.children
    }) : assert(children.isNotEmpty){

    boxDecorationSelected =  BoxDecoration(
      border: Border.all(
                color: colorStrokeSelected!,
                width: 2),
      borderRadius: BorderRadius.circular(50) 
      );
    }

  final List<Icon> children;
  final Function(int)? onTap;
  final Color? colorContainer;
  final Color? colorStrokeSelected;
  final Color? colorForegraundSelected;
        Color? colorCurrentForegraund;
  final Color? colorBackgroundSelected;
  late  Decoration boxDecorationSelected;  
  final double scale;
  final double elevationSelected;

  @override
  State<CustomBottonAnimatedBar> createState() => _CustomBottonAnimatedBarState();
}

class _CustomBottonAnimatedBarState extends State<CustomBottonAnimatedBar> with TickerProviderStateMixin {

  late final AnimationController _controller;
  late final Animation _translateAnimation;
  late final Animation _scaleAnimation;
  late final Animation _colorBackgroundSelectedAnimation;

  final _keyContainer = GlobalKey();

  int _currentIndex = 0;

  bool _isCurrendIndex(int index) => _currentIndex == index;

  @override
  void initState() {

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300)
      );

    _scaleAnimation = Tween(
      begin: 1.0,
      end: widget.scale
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.bounceOut));

    _colorBackgroundSelectedAnimation = ColorTween(
      begin: widget.colorContainer,
      end: widget.colorBackgroundSelected,
    ).animate(_controller);

    _translateAnimation = Tween(
      begin: 0.0,
      end:(0.0-widget.elevationSelected),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.bounceOut));

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    _controller.forward();

    return  Container(
      key: _keyContainer,
      width: double.infinity,
      height: 50,
      color: widget.colorContainer,
        child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(widget.children.length,
                    (index){
                      return GestureDetector(
                        onTap: (){
                          setState(() {
                            _currentIndex = index;
                            _controller.forward(from: 0);
                          });
                          if (widget.onTap != null) widget.onTap!(index);
                        },
                        child: AnimatedBuilder(
                          animation: _controller,
                          builder: (context,_) {
                            return Transform.translate(
                              offset: Offset(0, _isCurrendIndex(index) ? _translateAnimation.value : 0),
                              child: Transform.scale(
                                scale: _isCurrendIndex(index) ? _scaleAnimation.value : 1,
                                child: Container(
                                  decoration: _isCurrendIndex(index) ? widget.boxDecorationSelected : null ,
                                  child: CircleAvatar(
                                    foregroundColor: _isCurrendIndex(index) ? widget.colorForegraundSelected : widget.colorCurrentForegraund ,
                                    backgroundColor: _isCurrendIndex(index) ? _colorBackgroundSelectedAnimation.value : widget.colorContainer,
                                    child: Icon(
                                      widget.children[index].icon,
                                      ),
                                  ),
                                ),
                              ),
                            );
                          }
                        ),
                      );
                    }
                  ) 
                ),
    );
  }
}
