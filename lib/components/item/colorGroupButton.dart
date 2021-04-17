import 'package:flutter/material.dart';

import 'package:app_frontend/sizeConfig.dart';

class ColorGroupButton extends StatefulWidget {
  final List <Map<Color,bool>> productColors;
  final void Function (int index) selectProductColor;

  ColorGroupButton(this.productColors, this.selectProductColor);

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
        itemCount: widget.productColors.length,
        itemBuilder: (context, index){
          Color key = widget.productColors[index].keys.toList()[0];
          return GestureDetector(
            onTap: (){
              widget.selectProductColor(index);
            },
            child: Container(
              width: SizeConfig.safeBlockHorizontal * 11,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: key
              ),
              child: widget.productColors[index][key] ? Icon(
                Icons.done,
                color: Colors.white,
              ): null,
            )
          );
        },
        separatorBuilder: (BuildContext context, int index){
          return SizedBox(width: SizeConfig.safeBlockHorizontal);
        },
      ),
    );
  }
}
