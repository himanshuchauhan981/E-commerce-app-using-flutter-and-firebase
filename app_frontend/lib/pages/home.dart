import 'package:app_frontend/components/categoryCarousel.dart';
import 'package:app_frontend/components/header.dart';
import 'package:flutter/material.dart';
import 'package:app_frontend/components/sidebar.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
    bool showCartIcon  = true;

    return Scaffold(
      key: _scaffoldKey,
      appBar: header('Shop Mart', _scaffoldKey,showCartIcon),
      drawer: sidebar(context),
      body: Container(
        height: 100.0,
        padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: CategoryCarousal(),
            )
          ],
        ),
      )
    );
  }
}
