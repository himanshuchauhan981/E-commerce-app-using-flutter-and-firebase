import 'package:flutter/material.dart';

import 'package:app_frontend/components/header.dart';
import 'package:app_frontend/components/sidebar.dart';
import 'package:app_frontend/services/userService.dart';

class WishList extends StatefulWidget {
  @override
  _WishListState createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  UserService _userService = new UserService();
  bool showCartIcon = true;
  List userList;

  setWishlistItems(){
    Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;
    setState(() {
      userList = args['userList'];
    });
  }

  void showInSnackBar(String msg, Color color) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: new Text(msg),
        action: SnackBarAction(
          label:'Close',
          textColor: Colors.white,
          onPressed: (){
            _scaffoldKey.currentState.removeCurrentSnackBar();
          },
        ),
      ),
    );
  }

  delete(int index){
    String productId = userList[index]['productId'];
    _userService.deleteUserWishlistItems(productId);
    setState(() {
      userList.removeAt(index);
      showInSnackBar('Item removed from wishlist', Colors.black);
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                          mainAxisAlignment: MainAxisAlignment.start,
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
                      onPressed: (){
                        delete(index);
                      },
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
