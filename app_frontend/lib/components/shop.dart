import 'package:app_frontend/components/header.dart';
import 'package:app_frontend/components/sidebar.dart';
import 'package:flutter/material.dart';

class Shop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
    bool showCartIcon = true;

    return Scaffold(
      key: _scaffoldKey,
      appBar: header('Shop', _scaffoldKey, showCartIcon),
      drawer: sidebar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              Container(
                constraints: new BoxConstraints.expand(
                  height: 130.0
                ),
                alignment: Alignment.bottomLeft,
                padding: EdgeInsets.only(left: 16.0, bottom: 8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  image: DecorationImage(
                    image: AssetImage('assets/shop/clothing.jpg'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(Color.fromRGBO(90,90,90, 0.8), BlendMode.modulate)
                  )
                ),
                child: Center(
                  child: Text(
                      'CLOTHING',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 35.0,
                      color: Colors.white,
                      letterSpacing: 1.0
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                constraints: new BoxConstraints.expand(
                    height: 130.0
                ),
                alignment: Alignment.bottomLeft,
                padding: EdgeInsets.only(left: 16.0, bottom: 8.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    image: DecorationImage(
                        image: AssetImage('assets/shop/accessories.png'),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(Color.fromRGBO(90,90,90, 0.8), BlendMode.modulate)
                    )
                ),
                child: Center(
                  child: Text(
                    'ACCESSORIES',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 35.0,
                        color: Colors.white,
                        letterSpacing: 1.0
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                constraints: new BoxConstraints.expand(
                    height: 130.0
                ),
                alignment: Alignment.bottomLeft,
                padding: EdgeInsets.only(left: 16.0, bottom: 8.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    image: DecorationImage(
                        image: AssetImage('assets/shop/shoes.jpg'),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(Color.fromRGBO(90,90,90, 0.8), BlendMode.modulate)
                    )
                ),
                child: Center(
                  child: Text(
                    'SHOES',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 35.0,
                        color: Colors.white,
                        letterSpacing: 1.0
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                constraints: new BoxConstraints.expand(
                    height: 130.0
                ),
                alignment: Alignment.bottomLeft,
                padding: EdgeInsets.only(left: 16.0, bottom: 8.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    image: DecorationImage(
                        image: AssetImage('assets/shop/watches.jpg'),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(Color.fromRGBO(90,90,90, 0.8), BlendMode.modulate)
                    )
                ),
                child: Center(
                  child: Text(
                    'WATCHES',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 35.0,
                        color: Colors.white,
                        letterSpacing: 1.0
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                constraints: new BoxConstraints.expand(
                    height: 130.0
                ),
                alignment: Alignment.bottomLeft,
                padding: EdgeInsets.only(left: 16.0, bottom: 8.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    image: DecorationImage(
                        image: AssetImage('assets/shop/bags.jpg'),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(Color.fromRGBO(90,90,90, 0.8), BlendMode.modulate)
                    )
                ),
                child: Center(
                  child: Text(
                    'BAGS',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 35.0,
                        color: Colors.white,
                        letterSpacing: 1.0
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
