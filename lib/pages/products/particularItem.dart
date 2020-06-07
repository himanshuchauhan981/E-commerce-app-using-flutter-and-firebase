import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:app_frontend/components/loader.dart';
import 'package:app_frontend/services/shoppingBagService.dart';
import 'package:app_frontend/components/item/productImage.dart';

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
  List<String> imageList;
  List<dynamic> size;
  List<dynamic> colors;
  Map<String,bool> errors = {'size':true,'color':true};
  String _id;
  String sizeValue = "";
  String colorValue = "";
  int quantity = 1;
  bool edit;

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
      _id = args['itemDetails']['id'];
      itemDetails = args['itemDetails'];
      size = args['itemDetails']['size'];
      colors = args['itemDetails']['color'];
      quantity = args['itemDetails']['quantity'];
      sizeValue = args['itemDetails']['selectedSize'];
      colorValue = args['itemDetails']['selectedColor'];
      edit = true;
    });
  }

  setItemDetails(){
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.black)
    );
    Map<String,dynamic> args = widget.itemDetails;
    setState(() {
      if(!widget.edit){
        _id = args['itemDetails'].documentID;
        itemDetails = args['itemDetails'];
        size = args['itemDetails']['size'];
        colors = args['itemDetails']['color'];
        edit = false;
      }
      else{
        editItemDetails();
      }
    });
  }

  setError(String key, bool value){
    setState(() {
      errors[key] = value;
    });
  }

  setProductOptions(key,value){
    setState(() {
      if(key == 'color'){
        colorValue = value;
      }
      else if(key == 'size'){
        sizeValue = value;
      }
    });
  }

  addToShoppingBag() async{
    if(colors.length == 0) setError('color', false);
    if(size.length == 0) setError('size', false);
    bool errorValue = errors.containsValue(true);
    if(errorValue){
      if(errors['size']) showInSnackBar('Select size',Colors.red);
      else if(errors['color']) showInSnackBar('Select color', Colors.red);
    }
    else{
      Loader.showLoadingScreen(context, keyLoader);
      ShoppingBagService _shoppingBagService = new ShoppingBagService();
      String msg = await _shoppingBagService.addToShoppingBag(_id,sizeValue,colorValue,quantity);
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
                      edit,
                      setError,
                      setProductOptions
                  ),
                ),
                Expanded(
                    flex: 4,
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
            )
        ),
      ),
    );
   }
}