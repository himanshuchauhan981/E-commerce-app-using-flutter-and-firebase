import 'package:flutter/material.dart';

import 'package:app_frontend/components/item/customTransition.dart';
import 'package:app_frontend/pages/products/particularItem.dart';
import 'package:app_frontend/services/productService.dart';
import 'package:app_frontend/components/modals/internetConnection.dart';
import 'package:app_frontend/services/userService.dart';

class SnapEffectCarousel extends StatefulWidget {
  @override
  _SnapEffectCarouselState createState() => _SnapEffectCarouselState();
}

class _SnapEffectCarouselState extends State<SnapEffectCarousel> {
  int _index = 0;
  List newArrivals = new List();
  ProductService _productService = new ProductService();
  UserService _userService = new UserService();

  _SnapEffectCarouselState(){
    listNewArrivals();
  }

  void listNewArrivals() async{
    bool connectionStatus = await _userService.checkInternetConnectivity();
    if(connectionStatus){
      List<Map<String,String>> newArrivalList = await _productService.newItemArrivals();
      setState(() {
        newArrivals = newArrivalList;
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

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: newArrivals.length,
      controller: PageController(
        viewportFraction: 0.7
      ),
      onPageChanged: (int index) => setState(()=> _index = index),
      itemBuilder: (context,index){
        var item = newArrivals[index];
        return Transform.scale(
          scale: index == _index ? 1 : 0.8,
          child: Column(
            children: <Widget>[
              Container(
                child: Expanded(
                  child: GestureDetector(
                    onTap: () {
                      showParticularItem(item);
                    },
                    child: Card(
                      semanticContainer: true,
                      clipBehavior: Clip.antiAlias,
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius:  BorderRadius.all(Radius.circular(8.0)),
                          image: DecorationImage(
                              image: NetworkImage(item['image']),
                              fit: BoxFit.cover
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0,left: 20.0, right: 20.0),
                child: index == _index ? Text(
                  item['name'],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0
                  ),
                ): Text(''),
              )
            ],
          ),
        );
      },
    );
  }
}