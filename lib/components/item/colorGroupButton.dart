import 'package:flutter/material.dart';

class ColorGroupButton extends StatefulWidget {
  final List<dynamic> colorList;
  final void Function (int index) selectColor;

  ColorGroupButton(this.colorList, this.selectColor);

  @override
  _ColorGroupButtonState createState() => _ColorGroupButtonState();
}

class _ColorGroupButtonState extends State<ColorGroupButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 50.0,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: NeverScrollableScrollPhysics(),
        itemCount: widget.colorList.length,
        itemBuilder: (context, index){
          return GestureDetector(
            onTap: (){
              widget.selectColor(index);
            },
            child: Container(
              width: 60.0,
              height: 60.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.colorList[index].keys.toList()[0]
              ),
              child: widget.colorList[index].values.toList()[0] ? Icon(
                Icons.done,
                color: Colors.white,
              ): null,
            )
          );
        },
        separatorBuilder: (BuildContext context, int index){
          return SizedBox(width: 10.0);
        },
      ),
    );
  }
}
