import 'package:app_frontend/components/header.dart';
import 'package:app_frontend/components/sidebar.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math' as math;

class ShoppingBag extends StatefulWidget {
  @override
  _ShoppingBagState createState() => _ShoppingBagState();
}

class _ShoppingBagState extends State<ShoppingBag> {
  List bagItemList = new List(0);

  String selectedSize;
  String selectedColor;

  void listBagItems(context) async {
    Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;
    setState(() {
      bagItemList = args['bagItems'];
    });
  }

  buildExpandedList(item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
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
                    item['selectedSize'],
                    style: TextStyle(
                        fontSize: 18.0,
                        letterSpacing: 1.0
                    ),
                  )
                ],
              ),
              Container(
                color: Colors.black45,
                height: 60,
                width: 1
              ),
              Column(
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
                    item['selectedColor'],
                    style: TextStyle(
                        fontSize: 18.0
                    ),
                  )
                ],
              ),
              Container(
                  color: Colors.black45,
                  height: 60,
                  width: 1
              ),
              Column(
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
                    '1',
                    style: TextStyle(
                        fontSize: 18.0
                    ),
                  )
                ],
              ),
            ],
          ),
          SizedBox(height: 7.0),
          ButtonTheme(
//            padding: EdgeInsets.symmetric(horizontal: 10.0),
            minWidth: 200.0,
            height: 50.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0)
            ),
            child: RaisedButton(
              onPressed: (){},
              child: Text(
                  'Edit',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  letterSpacing: 1.0
                ),
              ),
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
                                  item['image'],
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
