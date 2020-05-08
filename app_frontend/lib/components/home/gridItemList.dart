import 'package:app_frontend/components/item/customTransition.dart';
import 'package:app_frontend/pages/products/particularItem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
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
    Navigator.push(
        context,
        CustomTransition(
            type: CustomTransitionType.downToUp,
            child: ParticularItem(
                itemDetails: args
            )
        )
    );
  }

  Widget build(BuildContext context){
    var size = MediaQuery.of(context).size;

    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    return SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: (itemWidth / itemHeight),
          crossAxisCount: 2,
          mainAxisSpacing: 20.0,
          crossAxisSpacing: 20.0,

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
      elevation: 0,
      semanticContainer: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Material(
              child: InkWell(
                onTap: () {},
                child: GridTile(
                  child: Image.network(
                    item['image'][0],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "\$${item['price'].toString()}.00",
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  item['name'],
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.grey
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}