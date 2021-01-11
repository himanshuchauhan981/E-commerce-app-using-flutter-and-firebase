import 'package:app_frontend/sizeConfig.dart';
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
    SizeConfig().init(context);
    return Container(
      alignment: Alignment.center,
      height: SizeConfig.safeBlockVertical * 5.5,
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
              width: SizeConfig.safeBlockHorizontal * 14,
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
          return SizedBox(width: SizeConfig.safeBlockHorizontal * 6);
        },
      ),
    );
  }
}
