import 'package:flutter/material.dart';

Widget header(String headerText,GlobalKey<ScaffoldState> scaffoldKey,bool  showIcon){

  return AppBar(
    centerTitle: true,
    title: Text(
      "${headerText[0].toUpperCase()}${headerText.substring(1)}",
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
        color: Colors.black
      ),
      onPressed: (){
        if(scaffoldKey.currentState.isDrawerOpen == false){
          scaffoldKey.currentState.openDrawer();
        }
        else{
          scaffoldKey.currentState.openEndDrawer();
        }
      },
    ),
    actions: <Widget>[
      Visibility(
        visible: showIcon,
        child: IconButton(
          icon: Icon(
            Icons.shopping_basket,
            size: 35.0,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
      )
    ],
  );
}