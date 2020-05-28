import 'package:flutter/material.dart';

class ShippingMethod extends StatefulWidget {
  @override
  _ShippingMethodState createState() => _ShippingMethodState();
}

class _ShippingMethodState extends State<ShippingMethod> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Shopping Bag',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black
              ),
            ),
            GestureDetector(
              child: Text(
                'Done',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                )
              ),
            )
          ],
        ),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Shipping',
                style: TextStyle(
                    fontSize: 35.0,
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.bold
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 60.0, bottom: 30.0),
                child: Center(
                  child: Image.asset(
                    'assets/cartonBox.png',
                    width: 250.0,
                    height: 250.0,
                  ),
                ),
              ),
              Text(
                'Shipping Method',
                style: TextStyle(
                  fontSize: 20.0,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.bold
                )
              ),
              ListTile(
                title: Text('UPS Ground'),
                subtitle: Text('Arrives in 3-5 days'),
                trailing: Text('free'),
              ),
              ListTile(
                title: Text('FedEx'),
                subtitle: Text('Arriving tomorrow'),
                trailing: Text('\$5.00'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
