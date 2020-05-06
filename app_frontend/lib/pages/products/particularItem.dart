import 'package:app_frontend/components/item/bottomSheet.dart';
import 'package:app_frontend/components/item/customTransition.dart';
import 'package:app_frontend/pages/home.dart';
import 'package:app_frontend/services/productService.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ParticularItem extends StatefulWidget {
  final Map <String,dynamic> itemDetails;

  ParticularItem({var key, @required this.itemDetails}):super(key: key);

  @override
  _ParticularItemState createState() => _ParticularItemState();
}

class _ParticularItemState extends State<ParticularItem> {
  var itemDetails;
  List<String> imageList;

  setItemDetails(){
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.black)
    );
    Map<String,dynamic> args = widget.itemDetails;
    setState(() {
      itemDetails = args['itemDetails'];
    });
  }

  addToShoppingBag(){
    ProductService productService = new ProductService();
    productService.addToShoppingBag(itemDetails.documentID);
  }

  carouselSlider(image,context){
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(image),
          fit: BoxFit.cover
        )
      ),
      child: Column(
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
                        context,
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
                    showModalBottomSheet(context: context, builder: (context){
                      return ShowBottomScreen();
                    });
                  },
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 25, 20),
            child: Row(
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
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext buildcontext) {
    setItemDetails();
    return Scaffold(
      body: SafeArea(
        child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                    flex: 6,
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
                        return carouselSlider(image,buildcontext);
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
                          SizedBox(height: 40.0),
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