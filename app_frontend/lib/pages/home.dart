import 'package:app_frontend/components/categoryCarousel.dart';
import 'package:app_frontend/components/header.dart';
import 'package:app_frontend/components/snapEffectCarousel.dart';
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
        padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
        child: Column(
          children: <Widget>[
            Flexible(
                child: Container(
                    height: 80.0,
                    child: CategoryCarousal()
                )
            ),
            Flexible(
              child: Padding(
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
            ),
            Flexible(
              child: SnapEffectCarousel(),
            ),
          ],
        ),
      )
    );
  }
}
