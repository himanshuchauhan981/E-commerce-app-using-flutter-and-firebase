import 'package:app_frontend/components/item/bottomSheet.dart';
import 'package:app_frontend/components/item/radioGroupButton.dart';
import 'package:app_frontend/pages/home.dart';
import 'package:flutter/material.dart';

import 'customTransition.dart';

class CustomCarouselSlider extends StatefulWidget {
  final String image;
  final BuildContext buildContext;
  final dynamic colors;

  CustomCarouselSlider(this.image, this.buildContext,this.colors);
  @override
  _CustomCarouselSliderState createState() => _CustomCarouselSliderState();
}

class _CustomCarouselSliderState extends State<CustomCarouselSlider> {
  List<Map<String, bool>> sizeList;

  selectItem(index) {
    String particularKey = sizeList[index].keys.toList()[0];
    var boolValues = sizeList.map((size) =>  size.values.toList()[0]);
    setState(() {
      if(boolValues.contains(true)){
        sizeList.forEach((size){
          String key = size.keys.toList()[0];
          if(size[key] == true) size[key] = false;
          else{
            String particularKey = sizeList[index].keys.toList()[0];
            if(particularKey == key){
              size[key] = true;
            }
          }
        });
      }
      else sizeList[index][particularKey] = true;
    });
  }

  setSizeList(List colors){
    List <Map<String, bool>> colorList = new List();
    colors.forEach((color){
      Map<String, bool> colorMap = new Map();
      colorMap[color] = false;
      colorList.add(colorMap);
    });
    return colorList;
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      sizeList = setSizeList(widget.colors);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(widget.image),
              fit: BoxFit.cover
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
                Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: sizeList.length,
                    itemBuilder: (context, index){
                      return RadioGroupButton(
                        selectItem,
                        index: index,
                        selectList: sizeList
                      );
                    },
                    separatorBuilder: (BuildContext context, int index){
                      return SizedBox(height: 10.0);
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      )
    );
  }
}
