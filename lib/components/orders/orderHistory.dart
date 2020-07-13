import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:app_frontend/components/header.dart';
import 'package:app_frontend/components/sidebar.dart';

class OrderHistory extends StatefulWidget {
  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  List itemList;
  void listOrderItems(context) async {
    Map<dynamic, dynamic> args = ModalRoute.of(context).settings.arguments;
    for(var items in args['data']){
      int total = 0;
      for(int i =0; i< items['orderDetails'].length;i++){
        total = total + items['orderDetails'][i]['quantity'] * items['orderDetails'][i]['price'];
      }
      items['totalPrice'] = total.toString();
    }
    setState(() {
      itemList = args['data'];
    });
  }


  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
    bool showCartIcon = true;
    listOrderItems(context);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      key: _scaffoldKey,
      appBar: header('Orders', _scaffoldKey, showCartIcon, context),
      drawer: sidebar(context),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(top:8.0),
          child: ListView.builder(
            itemCount: itemList.length,
            itemBuilder: (BuildContext context, int index){
              List item = itemList[index]['orderDetails'];
              String totalPrice = itemList[index]['totalPrice'];
              Timestamp orderedDate = itemList[index]['orderDate'];
              print(timeago.format(orderedDate.toDate(),locale: 'en_short'));
              return Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 0.0),
                child: Card(
                  elevation: 3.0,
                  child: Column(
                    children: <Widget>[
                      Container(
                        constraints: BoxConstraints.expand(
                          height: 200.0
                        ),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(item[index]['productImage']),
                            fit: BoxFit.fill,
                            colorFilter: ColorFilter.mode(
                              Color.fromRGBO(90,90,90, 0.8),
                              BlendMode.modulate
                            )
                          )
                        ),
                        child: Stack(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                '${orderedDate}'
                              ),
                            ),
                            Center(
                              child: Text(
                                'Order Placed',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'Novasquare',
                                  letterSpacing: 1.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: item.length,
                        itemBuilder: (BuildContext context, int itemIndex){
                          return ListTile(
                            leading: CircleAvatar(
                              radius: 30.0,
                              backgroundImage: NetworkImage(
                                item[itemIndex]['productImage'],
                              ),
                            ),
                            title: Text(
                              item[itemIndex]['productName'],
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                            subtitle: Text(
                              "\$ ${item[itemIndex]['price']}.00",
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                          );
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            "Total: \$ $totalPrice.00",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          ButtonTheme(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(7.0))
                            ),
                            height: 50.0,
                            minWidth: 160.0,
                            child: RaisedButton(
                              color: Color(0xff313134),
                              onPressed: (){ },
                              child: Text(
                                'REORDER',
                                style: TextStyle(
                                  fontSize: 17.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 10.0)
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
