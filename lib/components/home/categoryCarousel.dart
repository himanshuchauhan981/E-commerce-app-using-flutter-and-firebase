import 'package:flutter/material.dart';

import 'package:app_frontend/components/loader.dart';
import 'package:app_frontend/components/modals/internetConnection.dart';
import 'package:app_frontend/services/userService.dart';
import 'package:app_frontend/services/productService.dart';

class Category{
  final String name;
  final String url;

  Category({this.name, this.url});
}

class CategoryCarousal extends StatefulWidget {
  @override
  _HorizontalListState createState() => _HorizontalListState();
}

class _HorizontalListState extends State<CategoryCarousal> {
  ProductService _productService = ProductService();
  UserService _userService = new UserService();
  List categoryList = [];
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  void listCategories() async {
    bool connectionStatus = await _userService.checkInternetConnectivity();
    if(connectionStatus){
      _productService.listCategories().then((categories){
        this.setState(() {
          categoryList = categories;
        });
      });
    }
    else{
      internetConnectionDialog(context);
    }
  }

  void initState(){
    super.initState();
    listCategories();
  }

  final category = <Category>[
    Category(
        name: 'CLOTHING',
        url: 'assets/shop/clothing.jpg'
    ),
    Category(
        name: 'ACCESSORIES',
        url: 'assets/shop/accessories.png'
    ),
    Category(
      name: 'SHOES',
      url: 'assets/shop/shoes.jpg'
    ),
    Category(
      name: 'ELECTRONICS',
      url: 'assets/shop/electronics.jpg'
    )
  ];

  void listSubCategories(String categoryId,String categoryName) async{
    bool connectionStatus = await _userService.checkInternetConnectivity();
    if(connectionStatus){
      Loader.showLoadingScreen(context, _keyLoader);
      List subCategory = await _productService.listSubCategories(categoryId);
      Map args = {'subCategory': subCategory, 'categoryName': categoryName};
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      Navigator.pushNamed(context, '/subCategory', arguments: args);
    }
    else{
      internetConnectionDialog(context);
    }

  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: AlwaysScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: categoryList.length,
      itemBuilder: (context, index){
        var item = categoryList[index];
        return Container(
          width: 200.0,
          child: GestureDetector(
            onTap: (){
              listSubCategories(item['id'],item['name']);
            },
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  image: DecorationImage(
                    image: AssetImage(item['image']),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Color.fromRGBO(90,90,90,0.8),
                      BlendMode.modulate
                    )
                  )
                ),
                child: Center(
                  child: Text(
                    item['name'].toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20.0,
                      color: Colors.white,
                      letterSpacing: 1.0,
                      fontFamily: 'NovaSquare'
                    ),
                  ),
                ),
              )
            ),
          ),
        );
      }
    );
  }
}

