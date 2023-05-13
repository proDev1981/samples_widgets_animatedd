import 'package:flutter/material.dart';

class ButtonWithOptions extends StatefulWidget{

  static const defaultDuration = Duration(milliseconds: 300);

  ButtonWithOptions(
    {
      super.key,
      this.height=50, 
      this.width=200,
      this.childOffset=30, 
      this.roundActions=20,
      this.roundChild=10,
      this.elevation=2,
      this.onTap,
      this.childColor=Colors.black,
      this.actionsColor=Colors.amber,
      this.duration=defaultDuration,
      required this.child,
      required this.actions,
    }
  );

  VoidCallback? onTap;
  double        height;
  double        width;
  double        childOffset;
  double        roundChild;
  double        roundActions;
  double        elevation;
  Duration      duration;
  final Widget  child;  
  List<Widget>  actions;
  Color         childColor;
  Color         actionsColor;

  @override
  State<ButtonWithOptions> createState() => _ButtonWithOptionsState();
}

class _ButtonWithOptionsState extends State<ButtonWithOptions> 
        with SingleTickerProviderStateMixin {

  bool                      _isExpanded   = false;
  bool                      _isMounted    = false;
  late AnimationController  _controller;
  late Animation            _animation;

  void _changeMode() => _isExpanded = !_isExpanded;

  void _tryCallback(Function? call) { if(call != null) {call();}}

  void _changeAnimationDirection(AnimationController controller) => 
          _isExpanded ? _controller.forward() : _controller.reverse();

  Offset _customOffset(Offset offset) => 
          !_isMounted ? const Offset(0.0,0.0) : offset;

  Widget _widgetButton(){
    return Container(
                  width: widget.width + widget.childOffset,
                  height: widget.height,
                  decoration: BoxDecoration(
                    color: widget.childColor,
                    borderRadius: BorderRadius.circular(widget.roundChild),
                    boxShadow: [ 
                      BoxShadow(
                        blurRadius: widget.elevation,
                        color: Colors.grey
                        )
                      ]
                  ),
                  alignment: Alignment.center,
                  child: widget.child
    );
  }

  Widget _widgetOptions(){
    return Container(
                  width: widget.width,
                  height: widget.height,
                  decoration: BoxDecoration(
                    color: widget.actionsColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(widget.roundActions),
                      topRight: Radius.circular(widget.roundActions)
                      )
                  ),
                  alignment: Alignment.center,
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: widget.actions,
                  )
                );
  }

  double _halfHeight() => widget.height/2;

  @override
  void initState(){

    _controller = AnimationController( vsync: this, duration: widget.duration );

    _animation  = CurveTween( 
      curve: const Interval( 0.0, 1.0, curve: Curves.ease)).animate(_controller);

    _isMounted = true;
    super.initState();
  }

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context){

    return AnimatedBuilder(
      animation: _animation,
      builder: (context,_) {
        return Center(
          child: SizedBox(
            height: widget.height,
            child: Stack(
              alignment: Alignment.center,
              children: [
                  Transform.translate(
                    offset: _customOffset(Offset(0.0,-_halfHeight() * _animation.value)),
                    child:  _widgetOptions()
                    ),
                  GestureDetector(
                    onTap: (){ 
                      setState(() {
                        _changeMode();
                        _changeAnimationDirection(_controller);
                        _tryCallback(widget.onTap);
                      });
                    },
                    child: Transform.translate(
                      offset: _customOffset(Offset(0.0, _halfHeight() * _animation.value)),
                      child:  _widgetButton()
                      ),
                  )
              ],
            ),
          ),
        );
      }
    );
  }
}