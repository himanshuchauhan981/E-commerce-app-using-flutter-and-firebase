import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:app_frontend/services/productService.dart';

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
    var items = _productService.featuredItems();
    items.listen((data){
      List<DocumentSnapshot> featuredItemsData = data.documents;
      List featuredItemList = featuredItemsData.map((DocumentSnapshot doc){
        return doc.data;
      }).toList();
      setState(() {
        featuredItems = featuredItemList;
      });
    });
  }

  void showParticularItem(item){
    Map<String,dynamic> args = new Map();

    args['itemDetails'] = item;
    Navigator.pushNamed(context, '/particularItem', arguments: args);
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
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
              child: Material(
                child: InkWell(
                  onTap: (){
                    showParticularItem(item);
                  },
                  child: GridTile(
                    footer: Container(
                      color: Colors.white70,
                      child: ListTile(
                        leading: Text(
                          item['name'],
                          style: TextStyle(
                              fontSize: 16.0
                          ),
                        ),
                      ),
                    ),
                    child: Image.network(
                      item['image'][0],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )
          )
        ],
      ),
    );
  }
}