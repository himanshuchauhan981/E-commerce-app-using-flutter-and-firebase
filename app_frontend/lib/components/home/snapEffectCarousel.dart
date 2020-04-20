import 'dart:convert';

import 'package:app_frontend/services/productService.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

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
    Response response = await _productService.newItemArrivals();
    List newArrivals = json.decode(response.body);
    setState(() {
      newArrival = newArrivals;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: newArrival.length,
      controller: PageController(
        viewportFraction: 0.8
      ),
      onPageChanged: (int index) => setState(()=> _index = index),
      itemBuilder: (context,index){
        var item = newArrival[index];
        return Transform.scale(
          scale: index == _index ? 1 : 0.9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
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