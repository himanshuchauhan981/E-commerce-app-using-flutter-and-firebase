import 'package:flutter/material.dart';

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

  void listSubCategories(String category) async{
    category = category.toLowerCase();
    List subCategory = await _productService.listSubCategories(category);
    Map args = {'subCategory': subCategory, 'category': category};
    Navigator.pushNamed(context, '/subCategory', arguments: args);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: AlwaysScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: category.length,
      itemBuilder: (context, index){
        var item = category[index];
        return Container(
          width: 200.0,
          child: GestureDetector(
            onTap: (){
              listSubCategories(item.name);
            },
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  image: DecorationImage(
                    image: AssetImage(item.url),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Color.fromRGBO(90,90,90,0.8),
                      BlendMode.modulate
                    )
                  )
                ),
                child: Center(
                  child: Text(
                    item.name,
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

