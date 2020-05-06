import 'package:app_frontend/components/header.dart';
import 'package:app_frontend/services/orderService.dart';
import 'package:flutter/material.dart';

class ShoppingBag extends StatefulWidget {
  @override
  _ShoppingBagState createState() => _ShoppingBagState();
}

class _ShoppingBagState extends State<ShoppingBag> {
  List bagItemList = new List(0);

  void listBagItems()async{
    OrderService orderService = new OrderService();
    List bagItems = await orderService.listBagItems();
    setState(() {
      bagItemList = bagItems;
    });
  }

  @override
  void initState() {
    super.initState();
    listBagItems();
  }
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
    bool showCartIcon  = false;

    return Scaffold(
      appBar: header('Shopping Bag', _scaffoldKey, showCartIcon),
    );
  }
}
