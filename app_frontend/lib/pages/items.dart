import 'package:flutter/material.dart';

import 'package:app_frontend/components/header.dart';

class Items extends StatefulWidget {
  @override
  _ItemsState createState() => _ItemsState();
}

class _ItemsState extends State<Items> {
  String heading;
  bool showIcon = true;
  List itemList = new List(0);

  setItems(){
    Map<String,dynamic> args = ModalRoute.of(context).settings.arguments;
    this.setState(() {
      heading = args['heading'];
      itemList = args['list'];
    });
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

    setItems();
    return Scaffold(
      key: _scaffoldKey,
      appBar: header(heading, _scaffoldKey, showIcon),
    );
  }
}
