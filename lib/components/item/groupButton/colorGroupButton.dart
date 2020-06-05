import 'package:flutter/material.dart';

class ColorGroupButton extends StatefulWidget {
  final List<Map<Color,bool>> selectList;
  final int index;
  final Function(int) selectItem;

  ColorGroupButton(this.selectItem,{
    Key key,
    this.selectList,
    this.index
  }): super(key: key);

  @override
  _ColorGroupButtonState createState() => _ColorGroupButtonState();
}

class _ColorGroupButtonState extends State<ColorGroupButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        GestureDetector(
          onTap: (){
            widget.selectItem(widget.index);
          },
          child: SizedBox(
            width: 32.0,
            height: 30.0,
            child: DecoratedBox(
              decoration: BoxDecoration(
                  color: widget.selectList[widget.index].keys.toList()[0]
              ),
              child: widget.selectList[widget.index].values.toList()[0] ? Icon(
                Icons.done,
                color: Colors.white,
              ): null
            ),
          ),
        )
      ],
    );
  }
}
