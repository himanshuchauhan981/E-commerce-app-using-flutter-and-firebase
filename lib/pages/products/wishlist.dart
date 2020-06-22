import 'package:flutter/material.dart';

import 'package:app_frontend/components/header.dart';
import 'package:app_frontend/components/sidebar.dart';

class WishList extends StatefulWidget {
  @override
  _WishListState createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool showCartIcon = true;
  List userList;

  setWishlistItems(){
    Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;
    setState(() {
      userList = args['userList'];
    });
  }

  @override
  Widget build(BuildContext context) {
    setWishlistItems();
    return Scaffold(
      key: _scaffoldKey,
      appBar: header('Wishlist', _scaffoldKey, showCartIcon, context),
      drawer: sidebar(context),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: ListView.separated(
          itemCount: userList.length,
          itemBuilder: (BuildContext context, int index){
            var item = userList[index];
            return Container(
              child: Card(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 120.0,
                      width: 140.0,
                      child: Image.network(
                        item['image'][0],
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(top: 10.0, left: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              item['productName'],
                              style: TextStyle(
                                fontSize: 19.0,
                                letterSpacing: 1.0,
                                fontWeight: FontWeight.bold
                              )
                            ),
                            SizedBox(height: 5.0),
                            Text(
                              "\$ ${item['price']}.00",
                              style: TextStyle(
                                fontSize: 17.0
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete_outline),
                      onPressed: (){},
                    )
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) => SizedBox(height: 10.0),
        ),
      ),
    );
  }
}
