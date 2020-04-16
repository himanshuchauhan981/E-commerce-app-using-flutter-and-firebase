import 'package:flutter/material.dart';

class Sidebar extends StatefulWidget {
  @override
  _SidebarState createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ListView(
            shrinkWrap: true,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.home),
                title:Text(
                  'HOME',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.shopping_cart),
                title: Text(
                  'SHOP',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.local_mall),
                title: Text(
                  'BAG',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.search),
                title: Text(
                  'SEARCH',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.local_shipping),
                title: Text(
                  'ORDERS',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.favorite_border),
                title: Text(
                  'WISHLIST',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text(
                  'PROFILE',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0
                  ),
                ),
              ),
              ListTile(
                leading: new Icon(Icons.exit_to_app),
                title: Text(
                  'LOGOUT',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
