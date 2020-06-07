import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'customTransition.dart';

import 'package:app_frontend/components/item/bottomSheet.dart';
import 'package:app_frontend/pages/home.dart';

class CustomProductImage extends StatefulWidget {
  final String image;
  final BuildContext buildContext;
  final dynamic sizes;
  final String selectedSize;
  final bool edit;
  final void Function(String key, bool value) setErrors;
  final void Function(String key, String value) setProductOptions;

  CustomProductImage(
      this.image,
      this.buildContext,
      this.sizes,
      this.selectedSize,
      this.edit,
      this.setErrors,
      this.setProductOptions
  );
  @override
  _CustomProductImageState createState() => _CustomProductImageState();
}

class _CustomProductImageState extends State<CustomProductImage> {
  Map<String, bool> sizeMap;
  List<bool> sizeBoolList;

  selectSize(index) {
    setState(() {
      for(int i=0;i<sizeMap.length;i++){
        String key = widget.sizes[i];
        if(i== index) sizeMap[key] = true;
        else sizeMap[key] = false;
      }
      sizeBoolList = sizeMap.values.toList();
    });
  }

  setSizeList(List sizes){
    sizeBoolList = List.generate(sizes.length, (_) => false);
    Map<String,bool> sizeList = new Map();
    sizes.forEach((size){
      sizeList[size] = false;
    });
    return sizeList;
  }

  setItemDetails(){
    setState(() {
      sizeMap = setSizeList(widget.sizes);
    });
  }

  @override
  void initState() {
    super.initState();
    setItemDetails();
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
                      decoration: BoxDecoration(
                        color: Colors.white
                      ),
                      child: RotatedBox(
                        quarterTurns: 1,
                        child: ToggleButtons(
                          children: List.generate(widget.sizes.length, (index){
                            return RotatedBox(
                              quarterTurns: 3,
                              child: Text(
                                widget.sizes[index],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            );
                          }),
                          isSelected: sizeBoolList,
                          onPressed: (index) => selectSize(index),
                          fillColor: Colors.black,
                          selectedColor: Colors.white,
                        ),
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
