import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:app_frontend/components/item/customTransition.dart';
import 'package:app_frontend/pages/products/particularItem.dart';
import 'package:app_frontend/services/productService.dart';
import 'package:app_frontend/components/modals/internetConnection.dart';
import 'package:app_frontend/services/userService.dart';

class GridItemList extends StatefulWidget {
  @override
  _GridItemListState createState() => _GridItemListState();
}

class _GridItemListState extends State<GridItemList> {

  ProductService _productService = new ProductService();
  UserService _userService = new UserService();

  _GridItemListState(){
    listFeaturedItems();
  }

  List featuredItems  = new List(0);

  void listFeaturedItems() async{
    bool connectionStatus = await _userService.checkInternetConnectivity();
    if(connectionStatus){
      List<Map<String,String>> featuredItemList = await _productService.featuredItems();
      setState(() {
        featuredItems = featuredItemList;
      });
    }
    else{
      internetConnectionDialog(context);
    }

  }

  void showParticularItem(Map item) async{
    bool connectionStatus = await _userService.checkInternetConnectivity();
    if(connectionStatus){
      String productId = item['productId'];
      Map itemDetails = await _productService.particularItem(productId);
      Navigator.push(
          context,
          CustomTransition(
              type: CustomTransitionType.downToUp,
              child: ParticularItem(
                itemDetails: itemDetails,
                editProduct: false,
              )
          )
      );
    }
    else{
      internetConnectionDialog(context);
    }
  }

  Widget build(BuildContext context){
    Size size = MediaQuery.of(context).size;

    double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    double itemWidth = size.width / 2;

    return SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: (itemWidth / itemHeight),
          crossAxisCount: 2,
          mainAxisSpacing: 20.0,
          crossAxisSpacing: 20.0,

        ),
        delegate: SliverChildBuilderDelegate((BuildContext context, int index){
          var item = featuredItems[index];
          return featuredItemCard(item,index);
        },
            childCount: featuredItems.length
        )
    );
  }

  Widget featuredItemCard(item,index){
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
                onTap: () {
                  showParticularItem(item);
                },
                child: GridTile(
                  child: Image.network(
                    item['image'],
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
                  "\$${item['price']}.00",
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