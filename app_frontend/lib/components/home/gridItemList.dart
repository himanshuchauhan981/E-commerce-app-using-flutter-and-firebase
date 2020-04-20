import 'dart:convert';

import 'package:app_frontend/services/productService.dart';
import 'package:flutter/material.dart';

class GridItemList extends StatefulWidget {
  @override
  _GridItemListState createState() => _GridItemListState();
}

class _GridItemListState extends State<GridItemList> {

  ProductService _productService = new ProductService();

  _GridItemListState(){
    listFeaturedItems();
  }

  List featuredItems  = new List(0);

  void listFeaturedItems() async{
    var items = await _productService.featuredItems();
    List itemList = json.decode(items.body);
    setState(() {
      featuredItems = itemList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: List.generate(featuredItems.length, (index){
        return Center(
          child: Text(
            'Item $index',
            style: Theme.of(context).textTheme.headline,
          ),
        );
      })
    );
  }
}
