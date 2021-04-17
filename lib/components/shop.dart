import 'package:flutter/material.dart';

import 'package:app_frontend/components/header.dart';
import 'package:app_frontend/components/sidebar.dart';
import 'package:app_frontend/services/productService.dart';
import 'package:app_frontend/components/loader.dart';
import 'package:app_frontend/components/modals/internetConnection.dart';
import 'package:app_frontend/services/userService.dart';

class Shop extends StatefulWidget {
  @override
  _ShopState createState() => _ShopState();
}


class _ShopState extends State<Shop> {
  ProductService _productService = new ProductService();
  UserService _userService = new UserService();
  List<Map<String,String>> categoryList  = new List();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  void listCategories(){
    Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;
    setState(() {
      categoryList = args['category'];
    });
  }

  void listSubCategories(String categoryId, String categoryName) async{
    bool connectionStatus = await _userService.checkInternetConnectivity();

    if(connectionStatus){
      Loader.showLoadingScreen(context, _keyLoader);
      List subCategory = await _productService.listSubCategories(categoryId);
      Map args = {
        'subCategory': subCategory,
        'categoryId': categoryId,
        'categoryName':categoryName
      };
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      Navigator.pushNamed(context, '/subCategory', arguments: args);
    }
    else{
      internetConnectionDialog(context);
    }

  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
    bool showCartIcon = true;

    listCategories();
    return WillPopScope(
      onWillPop: () async{
        Navigator.pushReplacementNamed(context,'/home');
        return true;
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: header('Shop', _scaffoldKey, showCartIcon, context),
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
                return GestureDetector(
                  onTap: (){
                    listSubCategories(item['id'],item['name']);
                  },
                  child: Container(
                    constraints: new BoxConstraints.expand(
                        height: 130.0
                    ),
                    alignment: Alignment.bottomLeft,
                    padding: EdgeInsets.only(left: 16.0, bottom: 8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      image: DecorationImage(
                        image: AssetImage(item['image']),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(Color.fromRGBO(90,90,90, 0.8), BlendMode.modulate)
                      )
                    ),
                    child: Center(
                      child: Text(
                        item['name'].toString().toUpperCase(),
                        style: TextStyle(
                          fontFamily: 'NovaSquare',
                          fontWeight: FontWeight.w600,
                          fontSize: 35.0,
                          color: Colors.white,
                          letterSpacing: 1.0
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        )
      ),
    );
  }
}
