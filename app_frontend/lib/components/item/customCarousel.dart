import 'package:app_frontend/components/item/bottomSheet.dart';
import 'package:app_frontend/components/item/groupButton/SizeGroupButton.dart';
import 'package:app_frontend/components/item/groupButton/colorGroupButton.dart';
import 'package:app_frontend/pages/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'customTransition.dart';

class CustomCarouselSlider extends StatefulWidget {
  final String image;
  final BuildContext buildContext;
  final dynamic sizes;
  final dynamic colors;
  final void Function(String key, bool value) setErrors;
  final void Function(String key, String value) setProductOptions;

  CustomCarouselSlider(this.image, this.buildContext,this.sizes,this.colors,this.setErrors,this.setProductOptions);
  @override
  _CustomCarouselSliderState createState() => _CustomCarouselSliderState();
}

class _CustomCarouselSliderState extends State<CustomCarouselSlider> {
  List<Map<String, bool>> sizeList;
  List<Map<Color,bool>> colorList;

  selectSize(index) {
    String particularKey = sizeList[index].keys.toList()[0];
    var boolValues = sizeList.map((size) =>  size.values.toList()[0]);
    setState(() {
      if(boolValues.contains(true)){
        widget.setErrors('size',true);
        sizeList.forEach((size){
          String key = size.keys.toList()[0];
          if(size[key] == true) size[key] = false;
          else{
            String particularKey = sizeList[index].keys.toList()[0];
            if(particularKey == key){
              size[key] = true;
              widget.setErrors('size',false);
            }
          }
        });
      }
      else{
        sizeList[index][particularKey] = true;
        widget.setErrors('size',false);
      }
      widget.setProductOptions('size',sizeList[index].keys.toList()[0]);
    });
  }

  selectColor(index){
    Color particularKey = colorList[index].keys.toList()[0];
    var boolValues = colorList.map((color) => color.values.toList()[0]);
    setState(() {
      if(boolValues.contains(true)){
        widget.setErrors('color',true);
        colorList.forEach((size){
          Color key = size.keys.toList()[0];
          if(size[key] == true) size[key] = false;
          else{
            Color particularKey = colorList[index].keys.toList()[0];
            if(particularKey == key){
              size[key] = true;
              widget.setErrors('color',false);
            }
          }
        });
      }
      else{
        colorList[index][particularKey] = true;
        widget.setErrors('color',false);
      }
    });
    String color = colorList[index].keys.toList()[0].toString().substring(10,16);
    widget.setProductOptions('color',color);
  }

  setSizeList(List sizes){
    List <Map<String, bool>> sizeList = new List();
    sizes.forEach((size){
      Map<String, bool> sizeMap = new Map();
      sizeMap[size] = false;
      sizeList.add(sizeMap);
    });
    return sizeList;
  }

  setColorList(List colors){
    List <Map<Color,bool>> colorList = new List();
    colors.forEach((value){
      Map<Color,bool> colorMap = new Map();
      colorMap[Color(int.parse(value))] = false;
      colorList.add(colorMap);
    });
    return colorList;
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      sizeList = setSizeList(widget.sizes);
      colorList = setColorList(widget.colors);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40.0), bottomRight: Radius.circular(40.0)),
          image: DecorationImage(
              image: NetworkImage(widget.image),
              fit: BoxFit.fill
          )
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 20, 25, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    size: 42.0,
                    color: Colors.grey,
                  ),
                  onPressed: (){
                    Navigator.pop(
                        widget.buildContext,
                        CustomTransition(
                            type: CustomTransitionType.upToDown,
                            child: Home()
                        ));
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.share,
                    size: 36.0,
                    color: Colors.grey,
                  ),
                  onPressed: (){
                    showModalBottomSheet(context: widget.buildContext, builder: (context){
                      return ShowBottomScreen();
                    });
                  },
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 25, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              textBaseline: TextBaseline.ideographic,
              children: <Widget>[
                RawMaterialButton(
                  onPressed: () {},
                  elevation: 2.0,
                  fillColor: Colors.white,
                  child: Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                  shape: CircleBorder(),
                ),
                SizedBox(width: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      height: 200.0,
                      width: 40.0,
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: sizeList.length,
                        itemBuilder: (context, index){
                          return SizeGroupButton(
                            selectSize,
                            index: index,
                            selectList: sizeList,
                          );
                        },
                        separatorBuilder: (BuildContext context, int index){
                          return SizedBox(height: 10.0);
                        },
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Container(
                      height: 200.0,
                      width: 40.0,
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: colorList.length,
                        itemBuilder: (context,index){
                          return ColorGroupButton(
                            selectColor,
                            index: index,
                            selectList: colorList,
                          );
                        },
                        separatorBuilder: (BuildContext context, int index){
                          return SizedBox(height: 10.0);
                        },
                      ),
                    ),
                  ],
                )

              ],
            ),
          )
        ],
      )
    );
  }
}
