import 'package:flutter/material.dart';

import 'package:app_frontend/components/header.dart';
import 'package:app_frontend/components/sidebar.dart';
import 'package:app_frontend/services/productService.dart';
import 'package:app_frontend/components/loader.dart';
import 'package:app_frontend/components/modals/internetConnection.dart';
import 'package:app_frontend/services/userService.dart';

class SubCategory extends StatefulWidget {
  @override
  _SubCategoryState createState() => _SubCategoryState();
}

class _SubCategoryState extends State<SubCategory> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  ProductService _productService = new ProductService();
  UserService _userService = new UserService();
  String heading;
  bool showIcon = false;
  List subCategoryList = new List();
  List <String> imageList = new List();

  setSubCategory(context){
    Map<dynamic,dynamic> args = ModalRoute.of(context).settings.arguments;
    this.setState(() {
      heading = args['categoryName'];
      subCategoryList = args['subCategory'];
    });
  }

  listSubCategoryItems(String subCategoryId, String subCategoryName, BuildContext context) async{
    bool connectionStatus = await _userService.checkInternetConnectivity();

    if(connectionStatus){
      Loader.showLoadingScreen(context, _keyLoader);
      List <Map<String,String>> items = await _productService.listSubCategoryItems(subCategoryId);
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      Navigator.pushNamed(context, '/items', arguments: {'items': items, 'heading': subCategoryName});
    }
    else{
      internetConnectionDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
    setSubCategory(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: header(heading, _scaffoldKey, showIcon, context),
      drawer: sidebar(context),
      body: GridView.builder(
        itemCount: subCategoryList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 8.0 / 10.0,
          crossAxisCount: 2
        ),
        itemBuilder: (BuildContext context, int index){
          String subCategoryId = subCategoryList[index]['id'];
          String name = subCategoryList[index]['name'];
          String imagePath = subCategoryList[index]['imageId'];
          return Padding(
            padding: EdgeInsets.all(5.0),
            child: Card(
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
                          listSubCategoryItems(subCategoryId,name,context);
                        },
                        child: GridTile(
                          footer: Container(
                            color: Colors.white70,
                            child: ListTile(
                              leading: Text(
                                name,
                                style: TextStyle(
                                  fontFamily: 'NovaSquare',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22.0
                                ),
                              ),
                            ),
                          ),
                          child: Image.network(
                            imagePath,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
