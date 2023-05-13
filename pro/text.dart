import 'package:flutter/material.dart' as material;

class Text extends material.StatelessWidget{

  Text(this._text);

  final String _text;
  material.TextStyle? _style;

  Text style(material.TextStyle style){
    _style = style;
    return this;
  }

  @override
  material.Widget build(material.BuildContext context) {
    return material.Text(
      _text,
      style: _style,
      );
  }
}