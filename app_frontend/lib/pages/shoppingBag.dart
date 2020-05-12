import 'package:app_frontend/components/header.dart';
import 'package:app_frontend/components/sidebar.dart';
import 'package:app_frontend/services/orderService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ShoppingBag extends StatefulWidget {
  @override
  _ShoppingBagState createState() => _ShoppingBagState();
}

class _ShoppingBagState extends State<ShoppingBag> {
  List bagItemList = new List(0);

  void listBagItems()async{
    OrderService orderService = new OrderService();
    List bagItems = await orderService.listBagItems();
    setState(() {
      bagItemList = bagItems;
    });
  }

  @override
  void initState() {
    super.initState();
    listBagItems();
  }
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
    bool showCartIcon  = false;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      key: _scaffoldKey,
      appBar: header('Shopping Bag', _scaffoldKey, showCartIcon, context),
      drawer: sidebar(context),
      body: Container(
        child: ListView.builder(
          itemCount: bagItemList.length,
          itemBuilder: (BuildContext context, int index){
            var item = bagItemList[index];
            print(item);
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0,horizontal: 20.0),
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 200.0,
                      width: 150.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                              image: NetworkImage(
                                  item['image'],
                              ),
                              fit: BoxFit.cover,
                          )
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              item['name'],
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Text(
                              "\$${item['price']}.00",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
