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
      body: Container(
        padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Flexible(
              fit: FlexFit.loose,
              child: Container(
                  height: 80.0,
                  child: CategoryCarousal()
              )
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 20.0),
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
              fit: FlexFit.tight,
              child: Container(
                  child: SnapEffectCarousel()
              ),
            ),
          ],
        ),
      )
    );
  }
}
