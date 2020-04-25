import 'package:app_frontend/components/header.dart';
import 'package:app_frontend/services/productService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SubCategory extends StatefulWidget {
  @override
  _SubCategoryState createState() => _SubCategoryState();
}

class _SubCategoryState extends State<SubCategory> {
  ProductService _productService = new ProductService();
  String heading;
  bool showIcon = false;
  List subCategoryList = new List();

  setSubCategory(context){
    Map<String,dynamic> args = ModalRoute.of(context).settings.arguments;
    print(args['list'][0]['subCategory']);
    this.setState(() {
      heading = args['heading'];
      subCategoryList = args['list'][0]['subCategory'];
    });
  }

  listSubCategoryItems(String name){
    name = name.toLowerCase();
    Map<String,dynamic> args = new Map();
    var items = _productService.listSubCategoryItems(name);

    items.listen((data){
      List<DocumentSnapshot> arrivalData = data.documents;
      var itemsList = arrivalData.map((DocumentSnapshot doc){
        print(doc.data);
        return doc.data;
      }).toList();

      args['heading'] = name;
      args['list'] = itemsList;
      Navigator.pushNamed(context, '/items', arguments: args);
    });
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
    setSubCategory(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: header(heading, _scaffoldKey, showIcon),
      body: GridView.builder(
        itemCount: subCategoryList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 8.0 / 10.0,
          crossAxisCount: 2
        ),
        itemBuilder: (BuildContext context, int index){
          String name = subCategoryList[index]['subCategoryName'];
          name = name[0].toUpperCase()+name.substring(1);
          String imagePath = subCategoryList[index]['image'];
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
                          listSubCategoryItems(name);
                        },
                        child: GridTile(
                          footer: Container(
                            color: Colors.white70,
                            child: ListTile(
                              leading: Text(
                                name,
                                style: TextStyle(
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
