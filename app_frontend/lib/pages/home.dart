import 'package:app_frontend/components/home/categoryCarousel.dart';
import 'package:app_frontend/components/header.dart';
import 'package:app_frontend/components/home/gridItemList.dart';
import 'package:app_frontend/components/home/snapEffectCarousel.dart';
import 'package:app_frontend/components/sidebar.dart';

import 'package:flutter/material.dart';

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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible(
              child: Container(
                  height: 80.0,
                  child: CategoryCarousal()
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 20.0),
              child: Text(
                'New Arrivals',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2
                ),
              ),
            ),
            Flexible(
              child: Container(
                height: 420.0,
                  child: SnapEffectCarousel()
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Text(
                'Featured',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            Flexible(
              child: Container(
                height: 100,
                child: GridItemList(),
              ),
            )
          ],
        ),
      )
    );
  }
}
