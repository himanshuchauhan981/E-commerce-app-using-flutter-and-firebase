import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:app_frontend/sizeConfig.dart';

class ProductSize extends StatefulWidget {
  final List<Map<String,bool>> productSizes;
  final Map customDimension;
  final List<Map<String,bool>> Function(List sizes) setSizeList;

  final void Function (int index) selectProductColor;

  ProductSize(this.productSizes,this.customDimension,this.setSizeList,this.selectProductColor);

  @override
  _ProductSizeState createState() => _ProductSizeState();
}

class _ProductSizeState extends State<ProductSize> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      height: widget.customDimension['sizeBoxHeight'],
      alignment: Alignment.center,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: widget.productSizes.length,
        itemBuilder: (context,index){
          String key = widget.productSizes[index].keys.toList()[0];
          return GestureDetector(
            onTap: (){
              widget.selectProductColor(index);
            },
            child: (
                Container(
                  width: SizeConfig.safeBlockHorizontal * 11.5,
                  height: widget.customDimension['sizeBoxHeight'],

                  decoration: BoxDecoration(
                      color: widget.productSizes[index][key] ? Colors.black : Colors.white,
                      borderRadius: BorderRadius.all(
                          Radius.circular(8)
                      ),
                      border: Border.all(
                        color: Colors.black,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[300],
                            blurRadius: 15.0,
                            spreadRadius: 2.0
                        )
                      ]
                  ),
                  child: Center(
                    child: Text(
                      widget.productSizes[index].keys.toList()[0],
                      style: TextStyle(
                        fontFamily: 'NovaSquare',
                        fontSize: SizeConfig.safeBlockHorizontal * 4.2,
                        color: widget.productSizes[index][key] ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                )),
          );
        },
        separatorBuilder: (BuildContext buildContext,int index) => SizedBox(width: 15.0),
      ),
    );
  }
}
