import 'package:flutter/material.dart';

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
              var item = itemList[index]['orderDetails'];
              return Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 0.0),
                child: SizedBox(
                  height: 340.0,
                  child: Card(
                    elevation: 3.0,
                    child: Column(
                      children: <Widget>[
                        Image.network(
                          item[index]['productImage'],
                          height: 200.0,
                          fit: BoxFit.fill,
                          width: MediaQuery.of(context).size.width,
                        )
                      ],
                    ),
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
