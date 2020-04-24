import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:app_frontend/services/productService.dart';


class SnapEffectCarousel extends StatefulWidget {
  @override
  _SnapEffectCarouselState createState() => _SnapEffectCarouselState();
}

class _SnapEffectCarouselState extends State<SnapEffectCarousel> {
  int _index = 0;

  List newArrival  = new List(0);
  ProductService _productService = new ProductService();

  _SnapEffectCarouselState(){
    listNewArrivals();
  }

  void listNewArrivals() async{
    var newArrivals = _productService.newItemArrivals();
    newArrivals.listen((data){
      List<DocumentSnapshot> arrivalData = data.documents;
      var newArrivalList = arrivalData.map((DocumentSnapshot doc){
        return doc.data;
      }).toList();
      setState(() {
        newArrival = newArrivalList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: newArrival.length,
      controller: PageController(
        viewportFraction: 0.7
      ),
      onPageChanged: (int index) => setState(()=> _index = index),
      itemBuilder: (context,index){
        var item = newArrival[index];
        return Transform.scale(
          scale: index == _index ? 1 : 0.8,
          child: Column(
            children: <Widget>[
              Container(
                child: Expanded(
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