import 'package:app_frontend/components/header.dart';
import 'package:app_frontend/components/item/productButton.dart';
import 'package:app_frontend/components/item/productSize.dart';
import 'package:app_frontend/components/sidebar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:app_frontend/components/loader.dart';
import 'package:app_frontend/services/shoppingBagService.dart';
import 'package:app_frontend/components/item/colorGroupButton.dart';
import 'package:app_frontend/components/item/customTransition.dart';
import 'package:app_frontend/pages/home.dart';
import 'package:app_frontend/sizeConfig.dart';

class ParticularItem extends StatefulWidget {
  final Map <String,dynamic> itemDetails;
  final bool edit;

  ParticularItem({var key, this.itemDetails, this.edit}):super(key: key);

  @override
  _ParticularItemState createState() => _ParticularItemState();
}

class _ParticularItemState extends State<ParticularItem> {
  final GlobalKey<ScaffoldState> _productScaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<State> keyLoader = new GlobalKey<State>();

  Map customDimension = new Map();
  List <Map<Color,bool>> productColors;
  List<Map<String,bool>> productSizes;
  bool editProduct;
  int productQuantity = 1;

  setItemDetails(item){
    Map<String,dynamic> args = widget.itemDetails;
    setState(() {
      if(!widget.edit){
        editProduct = false;
        productColors = setColorList(args['color']);
        productSizes = setSizeList(args['size']);
      }
    });
  }

  setProductQuantity(String type){
    setState(() {
      if(type == 'inc'){
        if(productQuantity != 5){
          productQuantity = productQuantity + 1;
        }
      }
      else{
        if(productQuantity != 1){
          productQuantity = productQuantity - 1;
        }
      }
    });
  }


  void setCustomWidth(String screenSize){
    if(screenSize == 'smallMobile'){
      customDimension['productImageHeight'] = SizeConfig.screenHeight / 2.4;
      customDimension['sizeBoxHeight'] = SizeConfig.safeBlockVertical * 7.5;
    }
    else if(screenSize == 'largeMobile'){
      customDimension['productImageHeight'] = SizeConfig.screenHeight / 2.2;
      customDimension['sizeBoxHeight'] = SizeConfig.safeBlockVertical * 6.5;
     }
    else if(screenSize == 'tablet'){
      customDimension['productImageHeight'] = SizeConfig.screenHeight / 2.3;
      customDimension['sizeBoxHeight'] = SizeConfig.safeBlockVertical * 6.5;
    }
  }

  List setColorList(List colors){
    List <Map<Color,bool>> colorList = new List();
    colors.forEach((value){
      Map<Color,bool> colorMap = new Map();
      colorMap[Color(int.parse(value))] = false;
      colorList.add(colorMap);
    });
    return colorList;
  }

  void selectProductColor(int index){
    List tempColorList = setColorList(widget.itemDetails['color']);
    Color key = tempColorList[index].keys.toList()[0];
    tempColorList[index][key] = true;
    setState(() {
      productColors = tempColorList;
    });
  }

  void selectProductSize(int index){
    List tempSizeList = setSizeList(widget.itemDetails['size']);
    String key = tempSizeList[index].keys.toList()[0];
    tempSizeList[index][key] = true;
    setState(() {
      productSizes = tempSizeList;
    });
  }

  List<Map<String,bool>> setSizeList(List sizes){
    List<Map<String,bool>> sizeList = new List();
    sizes.forEach((size) {
      Map<String,bool> sizeMap = new Map();
      sizeMap[size] = false;
      sizeList.add(sizeMap);
    });
    return sizeList;
  }

  void showInSnackBar(String msg, Color color) {
    _productScaffoldKey.currentState.showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: new Text(msg),
        action: SnackBarAction(
          label:'Close',
          textColor: Colors.white,
          onPressed: (){
            _productScaffoldKey.currentState.removeCurrentSnackBar();
          },
        ),
      ),
    );
  }


  checkoutProduct(){
    String selectedSize;
    String selectedColor;
    if(selectedSize == '' && productSizes.length != 0) showInSnackBar('Select size',Colors.red);
    else if(selectedColor == '' && productColors.length != 0) showInSnackBar('Select color', Colors.red);
    else{
      Map<String,dynamic> args = new Map<String, dynamic>();
      args['price'] = widget.itemDetails['price'];
      args['productId'] = widget.itemDetails['productId'];
      args['quantity'] = productQuantity;
      args['size'] = selectedSize;
      args['color'] = selectedColor;
      Navigator.of(context).pushNamed('/checkout/address',arguments: args);
    }
  }

  addToShoppingBag() async{
    String selectedSize = '';
    String selectedColor = '';
    for(Map size in productSizes){
      if(size.values.toList()[0]) selectedSize = size.keys.toList()[0];
    }

    for(Map color in productColors) {
      if (color.values.toList()[0])
        selectedColor = color.toString().substring(7, 16);
    }

    if(selectedSize == '') showInSnackBar('Select size',Colors.red);
    else if(selectedColor == '') showInSnackBar('Select color', Colors.red);
    else{
      Loader.showLoadingScreen(context, keyLoader);
      ShoppingBagService _shoppingBagService = new ShoppingBagService();
      String msg = await _shoppingBagService.add(widget.itemDetails['productId'],selectedSize,selectedColor,productQuantity);
      Navigator.of(keyLoader.currentContext, rootNavigator: true).pop();
      showInSnackBar(msg,Colors.black);
    }
  }


  @override
  void initState() {
    super.initState();
    setItemDetails(widget.itemDetails);
  }

  @override
  Widget build(BuildContext buildContext) {
    SizeConfig().init(buildContext);
    setCustomWidth(SizeConfig.screenSize);
    return Scaffold(
      key: _productScaffoldKey,
      appBar: header('Product Details', _productScaffoldKey, true, context),
      drawer: sidebar(context),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.25,0.2],
              colors: [Color(0xff4CEEFB), Colors.white],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              SizeConfig.safeBlockHorizontal * 6.7,
              SizeConfig.topPadding,
              SizeConfig.safeBlockHorizontal * 6.7,
              SizeConfig.topPadding
            ),
            child: SizedBox(
              height: SizeConfig.screenHeight,
              width: SizeConfig.screenWidth,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35)
                ),
                color: Colors.red,
                elevation: 10.0,
                margin: EdgeInsets.zero,
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    Container(
                      height: customDimension['productImageHeight'],
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(widget.itemDetails['image']),
                          fit: BoxFit.fill
                        )
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: SizeConfig.screenWidth,
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: SizeConfig.safeBlockHorizontal * 5
                        ),
                        margin: EdgeInsets.zero,
                        decoration: BoxDecoration(
                          color: Color(0xff4CCEFB),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'T-Shirt',
                                    style: TextStyle(
                                      fontFamily: 'NovaSquare',
                                      fontSize: SizeConfig.safeBlockHorizontal * 4.5,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.0
                                    ),
                                  ),
                                  Text(
                                    "\$${widget.itemDetails['price']}.00",
                                    style: TextStyle(
                                      fontSize: SizeConfig.safeBlockHorizontal * 4.8,
                                      fontFamily: 'NovaSquare',
                                      color: Colors.white70,
                                      fontWeight: FontWeight.bold
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 10.0),
                            Text(
                              widget.itemDetails['name'],
                              style: TextStyle(
                                fontFamily: 'NovaSquare',
                                fontSize: SizeConfig.safeBlockHorizontal * 3.8,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.0,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: SizeConfig.safeBlockVertical * 1.2),
                              child: Center(
                                child: Text(
                                  'Color',
                                  style: TextStyle(
                                    fontFamily: 'NovaSquare',
                                    fontSize: SizeConfig.safeBlockHorizontal * 5,
                                    letterSpacing: 1.0,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            ),
                            ColorGroupButton(productColors, selectProductColor),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: SizeConfig.safeBlockVertical * 1.2),
                              child: Center(
                                child: Text(
                                  'Size',
                                  style: TextStyle(
                                      fontFamily: 'NovaSquare',
                                      fontSize: SizeConfig.safeBlockHorizontal * 5,
                                      letterSpacing: 1.0,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            ),
                            ProductSize(productSizes, customDimension, setSizeList,selectProductSize),
                            Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: SizeConfig.safeBlockVertical * 1.2),
                                child: Text(
                                  'Quantity',
                                  style: TextStyle(
                                      fontFamily: 'NovaSquare',
                                      fontSize: SizeConfig.safeBlockHorizontal * 5,
                                      letterSpacing: 1.0,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                MaterialButton(
                                  onPressed: (){
                                    setProductQuantity('inc');
                                  },
                                  color: Colors.white,
                                  child: Icon(
                                    Icons.add,
                                    size: SizeConfig.safeBlockHorizontal * 7,
                                  ),
                                  padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 3),
                                  shape: CircleBorder(),
                                  elevation: 18.0,
                                ),
                                Text(
                                  '$productQuantity',
                                  style: TextStyle(
                                      fontSize: SizeConfig.safeBlockHorizontal * 7,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                MaterialButton(
                                  onPressed: (){
                                    setProductQuantity('dec');
                                  },
                                  textColor: Colors.white,
                                  color: Colors.black,
                                  child: Icon(
                                    Icons.remove,
                                    size: SizeConfig.safeBlockHorizontal * 7,
                                  ),
                                  padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 3),
                                  shape: CircleBorder(),
                                  elevation: 18.0,
                                ),
                              ],
                            ),
                            SizedBox(height: 10.0),
                            ProductButtons(addToShoppingBag, checkoutProduct),
                          ]
                        )
                      )
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
   }
}