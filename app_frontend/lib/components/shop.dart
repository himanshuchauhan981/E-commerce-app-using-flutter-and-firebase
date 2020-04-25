import 'package:app_frontend/components/header.dart';
import 'package:app_frontend/components/sidebar.dart';
import 'package:app_frontend/services/productService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class Shop extends StatefulWidget {
  @override
  _ShopState createState() => _ShopState();
}


class _ShopState extends State<Shop> {

  ProductService _productService = new ProductService();

  List categoryList  = new List(0);

  void listCategories(){
    var categories = _productService.listAllCategories();
    categories.listen((data){
      List<DocumentSnapshot> categoryData = data.documents;
      var list = categoryData.map((DocumentSnapshot doc){
        print(doc.data);
        return doc.data;
      }).toList();
      setState(() {
        categoryList = list;
      });
      print(categoryList[0]['categoryImage']);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listCategories();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
    bool showCartIcon = true;

//    listCategories();
    return Scaffold(
      key: _scaffoldKey,
      appBar: header('Shop', _scaffoldKey, showCartIcon),
      drawer: sidebar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: ListView.separated(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: categoryList.length,
            separatorBuilder: (BuildContext context, int index){
              return SizedBox(height: 20.0);
            },
            itemBuilder: (context,index){
              var item = categoryList[index];
              return Container(
                constraints: new BoxConstraints.expand(
                    height: 130.0
                ),
                alignment: Alignment.bottomLeft,
                padding: EdgeInsets.only(left: 16.0, bottom: 8.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    image: DecorationImage(
                        image: AssetImage(item['categoryImage']),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(Color.fromRGBO(90,90,90, 0.8), BlendMode.modulate)
                    )
                ),
                child: Center(
                  child: Text(
                    item['categoryName'].toString().toUpperCase(),
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 35.0,
                        color: Colors.white,
                        letterSpacing: 1.0
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      )
    );
  }
}
