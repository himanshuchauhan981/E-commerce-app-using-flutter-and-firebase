import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:app_frontend/components/loader.dart';
import 'package:app_frontend/services/shoppingBagService.dart';
import 'package:app_frontend/components/item/productImage.dart';
import 'package:app_frontend/components/item/colorGroupButton.dart';

class ParticularItem extends StatefulWidget {
  final Map <String,dynamic> itemDetails;
  final bool edit;

  ParticularItem({var key, this.itemDetails, this.edit}):super(key: key);

  @override
  _ParticularItemState createState() => _ParticularItemState();
}

class _ParticularItemState extends State<ParticularItem> {
  final GlobalKey<State> keyLoader = new GlobalKey<State>();
  var itemDetails;
  List<dynamic> size;
  List<dynamic> colors;
  String productId;
  String sizeValue = "";
  String colorValue = "";
  int quantity = 1;
  bool editProduct;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void showInSnackBar(String msg, Color color) {
    _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          backgroundColor: color,
          content: new Text(msg),
          action: SnackBarAction(
            label:'Close',
            textColor: Colors.white,
            onPressed: (){
              _scaffoldKey.currentState.removeCurrentSnackBar();
            },
          ),
        ),
    );
  }

  editItemDetails(){
    Map<String,dynamic> args = widget.itemDetails;

    setState(() {
      editProduct = true;
      sizeValue = args['itemDetails']['selectedSize'];
      colorValue = args['itemDetails']['selectedColor'];
      productId = args['itemDetails']['id'];
      itemDetails = args['itemDetails'];
      size = args['itemDetails']['size'];
      colors = setColorList(args['itemDetails']['color']);
      quantity = args['itemDetails']['quantity'];
      int index = args['itemDetails']['color'].indexOf("0xFF$colorValue");
      selectColor(index);
    });

  }

  setItemDetails(){
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.black)
    );
    Map<String,dynamic> args = widget.itemDetails;
    setState(() {
      if(!widget.edit){
        editProduct = false;
        productId = args['itemDetails'].documentID;
        itemDetails = args['itemDetails'];
        size = args['itemDetails']['size'];
        colors = setColorList(args['itemDetails']['color']);
      }
      else{
        editItemDetails();
      }
    });
  }

  setSizeOptions(String size){
    setState(() {
      sizeValue = size;
    });
  }

  addToShoppingBag() async{
    if(sizeValue == '' && size.length != 0) showInSnackBar('Select size',Colors.red);
    else if(colorValue == '' && colors.length != 0) showInSnackBar('Select color', Colors.red);
    else{
      Loader.showLoadingScreen(context, keyLoader);
      ShoppingBagService _shoppingBagService = new ShoppingBagService();
      String msg = await _shoppingBagService.addToShoppingBag(productId,sizeValue,colorValue,quantity);
      Navigator.of(keyLoader.currentContext, rootNavigator: true).pop();
      showInSnackBar(msg,Colors.black);
    }
  }

  setQuantity(String type){
    setState(() {
      if(type == 'inc'){
        if(quantity != 5){
          quantity = quantity + 1;
        }
      }
      else{
        if(quantity != 1){
          quantity = quantity - 1;
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
    Color particularKey = colors[index].keys.toList()[0];
    var boolValues = colors.map((color) => color.values.toList()[0]);
    setState(() {
      if(boolValues.contains(true)){
        colors.forEach((color){
          Color key = color.keys.toList()[0];
          if(color[key] == true) color[key] = false;
          else{
            Color particularKey = colors[index].keys.toList()[0];
            if(particularKey == key){
              color[key] = true;
            }
          }
        });
      }
      else{
        colors[index][particularKey] = true;
      }
      colorValue = particularKey.value.toRadixString(16).substring(2);
    });
  }

  @override
  void initState() {
    super.initState();
    setItemDetails();
  }

  @override
  Widget build(BuildContext buildContext) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height + 22.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    flex: 6,
                    child: CustomProductImage(
                      itemDetails['image'][0],
                      buildContext,
                      size,
                      sizeValue,
                      editProduct,
                      productId,
                      setSizeOptions
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            itemDetails['name'],
                            style: TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.1
                            ),
                          ),
                          SizedBox(height: 7.0),
                          Text(
                            "\$${itemDetails['price'].toString()}.00",
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Center(
                            child: Text(
                              'Color',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.0
                              ),
                            ),
                          ),
                          SizedBox(height: 10.0),
                          ColorGroupButton(this.colors, this.selectColor),
                          SizedBox(height: 10.0),
                          Center(
                            child: Text(
                              'Quantity',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.0
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              MaterialButton(
                                onPressed: (){
                                  setQuantity('inc');
                                },
                                color: Colors.white,
                                child: Icon(
                                  Icons.add,
                                  size: 30.0,
                                ),
                                padding: EdgeInsets.all(12.0),
                                shape: CircleBorder(),
                              ),
                              Text(
                                quantity.toString(),
                                style: TextStyle(
                                  fontSize: 26.0,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              MaterialButton(
                                onPressed: (){
                                  setQuantity('dec');
                                },
                                textColor: Colors.white,
                                color: Colors.black,
                                child: Icon(
                                    Icons.remove,
                                    size: 30.0
                                ),
                                padding: EdgeInsets.all(12.0),
                                shape: CircleBorder(),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.0),
                          Divider(
                              color: Colors.black
                          ),
                          SizedBox(height: 10.0),
                          Row(
                            children: <Widget>[
                              ButtonTheme(
                                minWidth: (MediaQuery.of(context).size.width - 30.0 - 10.0) /2,
                                child: FlatButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4)
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 20.0),
                                  color: Colors.black,
                                  child: Text(
                                    'ADD TO BAG',
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.white
                                    ),
                                  ),
                                  onPressed: (){
                                    addToShoppingBag();
                                  },
                                ),
                              ),
                              SizedBox(width: 10.0),
                              ButtonTheme(
                                minWidth: (MediaQuery.of(context).size.width - 30.0 - 10.0) /2,
                                child: FlatButton(
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.circular(4)
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 20.0),
                                  color: Colors.white,
                                  child: Text(
                                    'Pay',
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.black
                                    ),
                                  ),
                                  onPressed: (){ },
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  )
                ],
              ),
            ),
          )
        ),
      ),
    );
   }
}