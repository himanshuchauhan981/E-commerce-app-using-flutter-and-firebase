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

  Widget build(BuildContext context){
    return SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2
        ),
        delegate: SliverChildBuilderDelegate((BuildContext context, int index){
          var item = featuredItems[index];
          return featuredItemCard(item);
        },
            childCount: featuredItems.length
        )
    );
  }

  Widget featuredItemCard(item){
    return Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Image.network(
        item['image'],
        fit: BoxFit.fill,
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)
      ),
    );
  }
}