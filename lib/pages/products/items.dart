import 'package:flutter/material.dart';

import 'package:app_frontend/components/item/customTransition.dart';
import 'package:app_frontend/pages/products/particularItem.dart';
import 'package:app_frontend/components/header.dart';
import 'package:app_frontend/components/sidebar.dart';
import 'package:app_frontend/services/productService.dart';
import 'package:app_frontend/services/userService.dart';
import 'package:app_frontend/components/modals/internetConnection.dart';

class Items extends StatefulWidget {
  @override
  _ItemsState createState() => _ItemsState();
}

class _ItemsState extends State<Items> {
  ProductService _productService = new ProductService();
  UserService _userService = new UserService();
  String heading;

  bool showIcon = true;
  bool showButton = true;
  int childCount = 4;
  var itemList = new List<dynamic>();

  setItems(){
    Map<String,dynamic> args = ModalRoute.of(context).settings.arguments;
    this.setState(() {
      heading = args['heading'];
      itemList = args['items'];
    });
  }

  setAllItems(){
    setState(() {
      showButton  = false;
      childCount =  itemList.length;
    });
  }

  openParticularItem(item) async{
    bool connectionStatus = await _userService.checkInternetConnectivity();

    if(connectionStatus){
      String productId = item['productId'];
      Map itemDetails = await _productService.particularItem(productId);
      Navigator.push(
          context,
          CustomTransition(
              type: CustomTransitionType.downToUp,
              child: ParticularItem(
                itemDetails: itemDetails,
                editProduct: false,
              )
          )
      );
    }
    else{
      internetConnectionDialog(context);
    }
  }

  Widget itemsCard(item){
    return Card(
      elevation: 0,
      semanticContainer: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Material(
              child: InkWell(
                onTap: () {
                  openParticularItem(item);
                },
                child: GridTile(
                  child: Image.network(
                    item['image'],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "\$${item['price'].toString()}.00",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  item['name'],
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.grey
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget setCustomScrollView(){
    var size = MediaQuery.of(context).size;

    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

    return CustomScrollView(
      slivers: <Widget>[
        SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: (itemWidth / itemHeight),
            crossAxisSpacing: 26.0,
            mainAxisSpacing: 26.0,
            crossAxisCount: 2,
          ),
          delegate: SliverChildBuilderDelegate((BuildContext context, int index){
            var item = itemList[index];
            return itemsCard(item);
          },
              childCount: childCount
          ),
        ),
        SliverFillRemaining(
            hasScrollBody: false,
            child: Visibility(
              visible: showButton,
              child: ButtonTheme(
                  minWidth: 250.0,
                  child: RaisedButton(
                    onPressed: (){
                      setAllItems();
                    },
                    color: Colors.white,
                    child: Text(
                      'Browse All',
                      style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: Colors.black,
                          width: 2.0
                      ),
                    ),
                  )
              ),
            )
        )
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

    setItems();
    return Scaffold(
      key: _scaffoldKey,
      appBar: header(heading, _scaffoldKey, showIcon,context),
      drawer: sidebar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
        child: setCustomScrollView(),
      ),
    );
  }
}
