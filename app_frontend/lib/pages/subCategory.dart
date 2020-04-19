import 'package:app_frontend/components/header.dart';
import 'package:flutter/material.dart';

class SubCategory extends StatefulWidget {
  @override
  _SubCategoryState createState() => _SubCategoryState();
}

class _SubCategoryState extends State<SubCategory> {
  String heading;
  bool showIcon = false;
  List subCategoryList = new List();

  setSubCategory(context){
    Map<String,dynamic>args = ModalRoute.of(context).settings.arguments;
    this.setState(() {
      heading = args['heading'];
      subCategoryList = args['list']['subCategory'];
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
          String name = subCategoryList[index]['name'];
          name = "${name[0].toUpperCase()}${name.substring(1)}";
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
                        onTap: (){},
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
                            subCategoryList[index]['image'],
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
