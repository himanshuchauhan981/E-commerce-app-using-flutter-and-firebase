import 'package:flutter/material.dart';


class RadioGroupButton extends StatefulWidget {
  List<Map<String, bool>> selectList;
  final int index;
  Function(int) selectItem;

  RadioGroupButton(this.selectItem, {
    Key key,
    this.selectList,
    this.index
  }): super(key: key);

  @override
  _RadioGroupButtonState createState() => _RadioGroupButtonState();
}

class _RadioGroupButtonState extends State<RadioGroupButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
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
                color: widget.selectList[widget.index].values.toList()[0] ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(4.0)
              ),
              child: Center(
                  child: Text(
                  widget.selectList[widget.index].keys.toList()[0],
                    style: TextStyle(
                      color: widget.selectList[widget.index].values.toList()[0] ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold
                    ),
                  )
              ),
            ),
          ),
        ),
      ],
    );
  }
}
