import 'package:flutter/material.dart';
import 'package:app_frontend/components/sidebar.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
            'Shop Mart',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22.0
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1.0,
        automaticallyImplyLeading: false,
        leading: IconButton(
            icon: Icon(
              Icons.menu,
              size: 35.0,
              color: Colors.black,
            ),
          onPressed: () {
              if(_scaffoldKey.currentState.isDrawerOpen == false){
                _scaffoldKey.currentState.openDrawer();
              }
              else{
                _scaffoldKey.currentState.openEndDrawer();
              }
          }
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.shopping_basket,
              size: 35.0,
              color: Colors.black,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Scaffold(
        key: _scaffoldKey,
          drawer: new Sidebar()
      ),
    );
  }
}
