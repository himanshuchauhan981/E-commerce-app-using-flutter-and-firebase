import 'package:flutter/material.dart';

import 'package:app_frontend/components/checkout/checkoutAppBar.dart';

class ShippingMethod extends StatefulWidget {
  @override
  _ShippingMethodState createState() => _ShippingMethodState();
}

class _ShippingMethodState extends State<ShippingMethod> {

  String selectedShippingMethod = 'UPS Ground';

  checkoutShippingMethod(){
    Map<String,dynamic> args = ModalRoute.of(context).settings.arguments;
    args['shippingMethod'] = selectedShippingMethod;
    Navigator.of(context).pushNamed('/checkout/paymentMethod', arguments: args);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CheckoutAppBar('Back', 'Done', checkoutShippingMethod),
      body: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Shipping',
                style: TextStyle(
                  fontFamily: 'NovaSquare',
                  fontSize: 40.0,
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
                contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                leading: Icon(Icons.local_shipping),
                title: Text(
                  'UPS Ground',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 3.0),
                    Text(
                      'Arrives in 3-5 days',
                      style: TextStyle(
                        fontSize: 16.0
                      ),
                    ),
                    Text(
                      'free',
                      style: TextStyle(
                        fontSize: 16.0
                      ),
                    )
                  ],
                ),
                trailing: Radio(
                  value: 'UPS Ground',
                  groupValue: selectedShippingMethod,
                  onChanged: (value) {
                    setState(() {
                      selectedShippingMethod = 'UPS Ground';
                    });
                  },
                )
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                leading: Icon(Icons.local_shipping),
                title: Text(
                  'FedEx',
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Arriving tomorrow',
                      style: TextStyle(
                          fontSize: 16.0
                      ),
                    ),
                    Text(
                      '\$5.00',
                      style: TextStyle(
                          fontSize: 16.0
                      ),
                    ),
                  ],
                ),
                  trailing: Radio(
                    value: 'FedEx',
                    groupValue: selectedShippingMethod,
                    onChanged: (value) {
                      setState(() {
                        selectedShippingMethod = 'FedEx';
                      });
                    },
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}
