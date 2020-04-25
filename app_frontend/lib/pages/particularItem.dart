import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ParticularItem extends StatefulWidget {
  @override
  _ParticularItemState createState() => _ParticularItemState();
}

class _ParticularItemState extends State<ParticularItem> {
  Map <String,dynamic> itemDetails  = new Map<String,dynamic>();

  setItemDetails(){
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.black)
    );
    Map<String,dynamic> args = ModalRoute.of(context).settings.arguments;
    print(args['itemDetails']);
    setState(() {
      itemDetails = args['itemDetails'];
    });
  }

  @override
  Widget build(BuildContext context) {
    setItemDetails();
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 7,
                  child: Container(
                    child: Image.network(
                        itemDetails['image'],
                      fit: BoxFit.fill,
                    ),
                  )
              ),
              Expanded(
                flex: 3,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        itemDetails['name'],
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.1
                        ),
                      ),
                      SizedBox(height: 7.0),
                      Text(
                        "\$${itemDetails['price'].toString()}.00",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0
                        ),
                      ),
                      Divider(
                        color: Colors.black
                      ),
                      SizedBox(height: 40.0),
                      Row(
                        children: <Widget>[
                          ButtonTheme(
                            minWidth: (MediaQuery.of(context).size.width - 30.0 - 10.0) /2,
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)
                              ),
                              padding: EdgeInsets.symmetric(vertical: 20.0),
                              color: Colors.black,
                              child: Text(
                                'ADD TO BAG',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.white
                                ),
                              ),
                              onPressed: (){},
                            ),
                          ),
                          SizedBox(width: 10.0),
                          ButtonTheme(
                            minWidth: (MediaQuery.of(context).size.width - 30.0 - 10.0) /2,
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(4)
                              ),
                              padding: EdgeInsets.symmetric(vertical: 20.0),
                              color: Colors.white,
                              child: Text(
                                'Pay',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.black
                                ),
                              ),
                              onPressed: (){},
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              )
            ],
          )
        ),
      ),
    );
   }
}
