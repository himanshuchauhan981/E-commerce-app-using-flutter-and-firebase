import 'package:app_frontend/components/loader.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:app_frontend/services/orderService.dart';
import 'package:app_frontend/components/item/customCarousel.dart';

class ParticularItem extends StatefulWidget {
  final Map <String,dynamic> itemDetails;

  ParticularItem({var key, this.itemDetails}):super(key: key);

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

  setItemDetails(){
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.black)
    );
    Map<String,dynamic> args = widget.itemDetails;
    setState(() {
      _id = args['itemDetails'].documentID;
      itemDetails = args['itemDetails'];
      size = args['itemDetails']['size'];
      colors = args['itemDetails']['color'];
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
    else if(size.length == 0) setError('size', false);
    bool errorValue = errors.containsValue(true);
    if(errorValue){
      if(errors['size']) showInSnackBar('Select size',Colors.red);
      else if(errors['color']) showInSnackBar('Select color', Colors.red);
    }
    else{
      Loader.showLoadingScreen(context, keyLoader);
      OrderService orderService = new OrderService();
      String msg = await orderService.addToShoppingBag(_id,sizeValue,colorValue);
      Navigator.of(keyLoader.currentContext, rootNavigator: true).pop();
      showInSnackBar(msg,Colors.black);
    }
  }

  @override
  Widget build(BuildContext buildcontext) {
    setItemDetails();
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                    flex: 7,
                    child: Carousel(
                      boxFit: BoxFit.cover,
                      autoplay: false,
                      animationCurve: Curves.fastOutSlowIn,
                      animationDuration: Duration(milliseconds: 1000),
                      dotSize: 6.0,
                      dotIncreasedColor: Colors.black,
                      dotBgColor: Colors.transparent,
                      dotPosition: DotPosition.bottomCenter,
                      dotVerticalPadding: 10.0,
                      showIndicator: true,
                      indicatorBgPadding: 7.0,
                      images: itemDetails['image'].map((image){
                        return CustomCarouselSlider(image,buildcontext,size,colors,setError,setProductOptions);
                      }).toList(),
                    ),
                ),
                Expanded(
                    flex: 3,
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