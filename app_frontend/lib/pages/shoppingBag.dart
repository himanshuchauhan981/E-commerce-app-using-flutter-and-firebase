import 'package:app_frontend/services/shoppingBagService.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math' as math;

import 'package:app_frontend/components/header.dart';
import 'package:app_frontend/components/item/customTransition.dart';
import 'package:app_frontend/components/sidebar.dart';
import 'package:app_frontend/pages/products/particularItem.dart';

class ShoppingBag extends StatefulWidget {
  @override
  _ShoppingBagState createState() => _ShoppingBagState();
}

class _ShoppingBagState extends State<ShoppingBag> {
  List bagItemList = new List(0);

  String selectedSize;
  String selectedColor;
  String totalPrice;
  ShoppingBagService _shoppingBagService = new ShoppingBagService();

  void listBagItems(context) async {
    Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;
    setState(() {
      bagItemList = args['bagItems'];
      totalPrice = setTotalPrice(args['bagItems']);
    });
  }

  String setTotalPrice(List items){
    int totalPrice = 0;
    items.forEach((item){
      totalPrice = totalPrice + (int.parse(item['price']) * item['quantity']);
    });
    return totalPrice.toString();
  }

  String colorList(String colorName){
    Map colorMap = new Map();
    colorMap['000000'] = 'Black';
    colorMap['0000ff'] = 'Blue';
    colorMap[''] = 'None';
    return colorMap[colorName];
  }

  void removeItem(item,context) async{
    bagItemList.removeWhere((items) => items['id'] == item['id']);
    await _shoppingBagService.removeBagItems(item['id']);
    setState(() {
      bagItemList = bagItemList;
    });
    Navigator.of(context, rootNavigator: true).pop();
  }

  void removeItemAlertBox(BuildContext context, Map id) {
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))
          ),
          title: Text(
            'Remove from cart',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0
            ),
          ),
          content: Text(
            'This product will be removed from cart',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0
            ),
          ),
          actions: <Widget>[
            Row(
              children: <Widget>[
                ButtonTheme(
                  minWidth: (MediaQuery.of(context).size.width - 120) /2,
                  child: FlatButton(
                    onPressed: (){
                      removeItem(id,context);
                    },
                    child: Text(
                      'Remove',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.redAccent
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                ButtonTheme(
                  minWidth: (MediaQuery.of(context).size.width - 120) /2,
                  child: FlatButton(
                    onPressed: (){
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.blue
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.0)
              ],
            )
          ],
        );
      }
    );
  }

  openParticularItem(item){
    Map<String,dynamic> args = new Map();
    args['itemDetails'] = item;
    Navigator.push(
        context,
        CustomTransition(
            type: CustomTransitionType.downToUp,
            child: ParticularItem(
              itemDetails: args,
              edit: true,
            )
        )
    );
  }

  buildExpandedList(item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width/3,
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Size',
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        item['selectedSize'].toString().length == 0 ? 'None':item['selectedSize'],
                        style: TextStyle(
                            fontSize: 18.0,
                            letterSpacing: 1.0
                        ),
                      )
                    ],
                  )
                ),
              ),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width/3,
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Color',
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        colorList(item['selectedColor']),
                        style: TextStyle(
                            fontSize: 18.0
                        ),
                      )
                    ],
                  )
                ),
              ),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width/3,
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Quantity',
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        "${item['quantity']}",
                        style: TextStyle(
                            fontSize: 18.0
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 7.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Ink(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.indigoAccent, width: 4.0),
                    color: Colors.indigo[900],
                    shape: BoxShape.circle
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20.0),
                    onTap: (){
                      openParticularItem(item);
                    },
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.edit,
                        size: 25.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 5.0),
                Ink(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.red, width: 4.0),
                      color: Colors.red[900],
                      shape: BoxShape.circle
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20.0),
                    onTap: (){
                      removeItemAlertBox(context,item);
                    },
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.remove_shopping_cart,
                        size: 25.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();
    bool showCartIcon = false;

    listBagItems(context);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      key: _scaffoldKey,
      appBar: header('Shopping Bag', _scaffoldKey, showCartIcon, context),
      drawer: sidebar(context),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 3.0, 20.0, 0.0),
          child: Container(
            height: 100.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Total',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                        Text(
                            '\$ $totalPrice.00',
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600
                          ),
                        )
                      ],
                    ),
                  ),
                  ButtonTheme(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7.0))
                    ),
                    minWidth: MediaQuery.of(context).size.width,
                    height: 50.0,
                    child: RaisedButton(
                      color: Color(0xff313134),
                      onPressed: (){},
                      child: Text(
                        'CONTINUE',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  )
                ],
            ),
          ),
        ),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: bagItemList.length,
          itemBuilder: (BuildContext context, int index) {
            var item = bagItemList[index];
            return ExpandableNotifier(
                child: Padding(
              padding: const EdgeInsets.all(10),
              child: ScrollOnExpand(
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: <Widget>[
                      ExpandablePanel(
                        theme: const ExpandableThemeData(
                          headerAlignment:
                              ExpandablePanelHeaderAlignment.center,
                          tapBodyToExpand: true,
                          tapBodyToCollapse: true,
                          hasIcon: false,
                        ),
                        header: Container(
                          color: Colors.indigoAccent,
                          child: Row(
                            children: [
                              Image(
                                image: NetworkImage(
                                  item['image'][0],
                                ),
                                height: 100.0,
                                width: 120.0,
                                fit: BoxFit.fill,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 6.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        item['name'],
                                        overflow: TextOverflow.clip,
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.white,
                                            letterSpacing: 1.0),
                                      ),
                                      SizedBox(height: 4.0),
                                      Text(
                                        "\$${item['price']}",
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white70),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              ExpandableIcon(
                                theme: const ExpandableThemeData(
                                  expandIcon: Icons.keyboard_arrow_right,
                                  collapseIcon: Icons.keyboard_arrow_down,
                                  iconColor: Colors.white,
                                  iconSize: 28.0,
                                  iconRotationAngle: math.pi / 2,
                                  iconPadding: EdgeInsets.only(right: 5),
                                  hasIcon: false,
                                ),
                              )
                            ],
                          ),
                        ),
                        expanded: buildExpandedList(item),
                      ),
                    ],
                  ),
                ),
              ),
            ));
          },
        ),
      ),
    );
  }
}
