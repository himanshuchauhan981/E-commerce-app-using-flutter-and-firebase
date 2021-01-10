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
  final GlobalKey<State> keyLoader = new GlobalKey<State>();
  List<Map<String,bool>> productSizes;
  List<Map<Color,bool>> productColors;
  String selectedSize = "";
  String selectedColor = "";
  int productQuantity = 1;
  bool editProduct;
  String image,name;

  final GlobalKey<ScaffoldState> _productScaffoldKey = new GlobalKey<ScaffoldState>();
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

  editItemDetails(){
    Map<String,dynamic> args = widget.itemDetails;
    setState(() {
      editProduct = true;
      selectedSize = args['itemDetails']['selectedSize'];
      selectedColor = args['itemDetails']['selectedColor'];
      productSizes = args['itemDetails']['size'];
      productColors = setColorList(args['itemDetails']['color']);
      productQuantity = args['itemDetails']['quantity'];
      int index = args['itemDetails']['color'].indexOf("0xFF$selectedColor");
      selectColor(index);
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

  setItemDetails(){
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.black)
    );
    Map<String,dynamic> args = widget.itemDetails;
    setState(() {
      if(!widget.edit){
        editProduct = false;
        productColors = setColorList(args['color']);
        productSizes = setSizeList(args['size']);
      }
      else{
        editItemDetails();
      }
    });
  }

  setSizeOptions(String size){
    setState(() {
      selectedSize = size;
    });
  }

  addToShoppingBag() async{
    if(selectedSize == '' && productSizes.length != 0) showInSnackBar('Select size',Colors.red);
    else if(selectedColor == '' && productColors.length != 0) showInSnackBar('Select color', Colors.red);
    else{
      Loader.showLoadingScreen(context, keyLoader);
      ShoppingBagService _shoppingBagService = new ShoppingBagService();
      String msg = await _shoppingBagService.add(widget.itemDetails['productId'],selectedSize,selectedColor,productQuantity);
      Navigator.of(keyLoader.currentContext, rootNavigator: true).pop();
      showInSnackBar(msg,Colors.black);
    }
  }

  checkoutProduct(){
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

  setColorList(List colors){
    List <Map<Color,bool>> colorList = new List();
    colors.forEach((value){
      Map<Color,bool> colorMap = new Map();
      colorMap[Color(int.parse(value))] = false;
      colorList.add(colorMap);
    });
    return colorList;
  }

  selectColor(index){
    Color particularKey = productColors[index].keys.toList()[0];
    var boolValues = productColors.map((color) => color.values.toList()[0]);
    setState(() {
      if(boolValues.contains(true)){
        productColors.forEach((color){
          Color key = color.keys.toList()[0];
          if(color[key] == true) color[key] = false;
          else{
            Color particularKey = productColors[index].keys.toList()[0];
            if(particularKey == key){
              color[key] = true;
            }
          }
        });
      }
      else{
        productColors[index][particularKey] = true;
      }
      selectedColor = particularKey.value.toRadixString(16).substring(2);
    });
  }

  @override
  void initState() {
    super.initState();
    setItemDetails();
  }

  @override
  Widget build(BuildContext buildContext) {
    SizeConfig().init(buildContext);
    return Scaffold(
      key: _productScaffoldKey,
      appBar: AppBar(
        title: Text(
          'Sub category name',
          style: TextStyle(
            fontFamily: 'NovaSquare',
            fontWeight: FontWeight.bold
          ),
        ),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(
              buildContext,
              CustomTransition(
                  type: CustomTransitionType.upToDown,
                  child: Home()
              ));
          },
          icon: Icon(
            Icons.keyboard_arrow_down,
            size: 40,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              size: 25,
              color: Colors.white
            ),
            onPressed: null,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[200]
          ),
          child: Column(
            children: [
              SizedBox(
                height: SizeConfig.screenHeight / 1.9,
                child: Image.network(widget.itemDetails['image']),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: SizeConfig.safeBlockVertical* 1.5,
                  horizontal: SizeConfig.safeBlockHorizontal * 4
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.itemDetails['name'],
                      style: TextStyle(
                        fontFamily: 'NovaSquare',
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Center(
                        child: Text(
                          'Color',
                          style: TextStyle(
                            fontFamily: 'NovaSquare',
                            fontSize: 26.0,
                          ),
                        ),
                      ),
                    ),
                    ColorGroupButton(productColors,selectColor),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Center(
                        child: Text(
                          'Size',
                          style: TextStyle(
                            fontFamily: 'NovaSquare',
                            fontSize: 26.0,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: SizeConfig.safeBlockVertical * 6.5,
                      alignment: Alignment.center,
                      child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: productSizes.length,
                        itemBuilder: (context,index){
                          String key = productSizes[index].keys.toList()[0];
                          return GestureDetector(
                            onTap: (){
                              List <Map<String,bool>> tempProductSizes = setSizeList(widget.itemDetails['size']);
                              tempProductSizes[index][key] = true;
                              this.setState(() {
                                productSizes = tempProductSizes;
                              });
                            },
                            child: (
                              Container(
                                width: SizeConfig.safeBlockHorizontal * 12.5,
                                decoration: BoxDecoration(
                                  color: productSizes[index][key] ? Colors.black : Colors.white,
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
                                    productSizes[index].keys.toList()[0],
                                    style: TextStyle(
                                      fontFamily: 'NovaSquare',
                                      fontSize: SizeConfig.safeBlockHorizontal * 4.2,
                                      color: productSizes[index][key] ? Colors.white : Colors.black,
                                    ),
                                  ),
                                ),
                              )),
                          );
                        },
                        separatorBuilder: (BuildContext buildContext,int index) => SizedBox(width: 15.0),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Center(
                        child: Text(
                          'Quantity',
                          style: TextStyle(
                            fontFamily: 'NovaSquare',
                            fontSize: 26.0,
                            letterSpacing: 1.0,
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
                            size: 30.0,
                          ),
                          padding: EdgeInsets.all(12.0),
                          shape: CircleBorder(),
                          elevation: 18.0,
                        ),
                        Text(
                          '$productQuantity',
                          style: TextStyle(
                              fontSize: 26.0,
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
                              size: 30.0
                          ),
                          padding: EdgeInsets.all(12.0),
                          shape: CircleBorder(),
                          elevation: 18.0,
                        ),
                      ],
                    ),
                    SizedBox(height: SizeConfig.safeBlockVertical * 2.8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:[
                        ButtonTheme(
                          padding: EdgeInsets.symmetric(
                              vertical: SizeConfig.safeBlockVertical * 2.5
                          ),
                          minWidth: SizeConfig.screenWidth / 2.4,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)
                            ),
                            elevation: 16.0,
                              onPressed: (){
                                addToShoppingBag();
                              },
                              color: Colors.white,
                              child: Text(
                                'Add to bag',
                                style: TextStyle(
                                  fontFamily: 'NovaSquare',
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.0,
                                  color: Colors.black
                                ),
                              )
                          ),
                        ),
                        ButtonTheme(
                          minWidth: SizeConfig.screenWidth / 2.4,
                          padding: EdgeInsets.symmetric(
                              vertical: SizeConfig.safeBlockVertical * 2.5
                          ),
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)
                            ),
                            elevation: 16.0,
                            onPressed: (){
                              checkoutProduct();
                            },
                            color: Colors.black,
                            child: Text(
                              'Pay',
                              style: TextStyle(
                                  fontFamily: 'NovaSquare',
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.0,
                                color: Colors.white
                              ),
                            )
                          ),
                        )
                      ]
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ),
    );
   }
}