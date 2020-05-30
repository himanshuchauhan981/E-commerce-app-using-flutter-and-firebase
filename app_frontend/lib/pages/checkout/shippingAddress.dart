import 'dart:collection';

import 'package:app_frontend/components/checkout/checkoutAppBar.dart';
import 'package:app_frontend/components/checkout/shippingAddressInput.dart';
import 'package:app_frontend/services/checkoutService.dart';
import 'package:flutter/material.dart';

class ShippingAddress extends StatefulWidget {
  @override
  _ShippingAddressState createState() => _ShippingAddressState();
}

class _ShippingAddressState extends State<ShippingAddress> {
  final _formKey = GlobalKey<FormState>();
  bool autoValidate = false;
  bool visibleInput = true;
  CheckoutService _checkoutService = new CheckoutService();
  HashMap addressValues = new HashMap();

  showSavedAddress(){
    return Container(
      child: Column(
        children: <Widget>[
          Text('No address saved'),
        ],
      ),
    );
  }

  validateInput() async{
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      await _checkoutService.newShippingAddress(addressValues);
    }
    else{
      setState(() {
        autoValidate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CheckoutAppBar('Cancel','Next'),
      body: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 10.0),
          child: Form(
            key: _formKey,
            autovalidate: autoValidate,
            child: SingleChildScrollView(
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
                  SizedBox(height: 25.0),
                  Center(
                    child: Icon(
                      Icons.local_shipping,
                      size: 220.0,
                    ),
                  ),
                  Text(
                    'Shipping Address',
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Visibility(
                    visible: visibleInput,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0,vertical: 10.0),
                      child: ShippingAddressInput(addressValues),
                    ),
                  ),
                  Visibility(
                    visible: !visibleInput,
                    child: showSavedAddress(),
                  ),
                  Center(
                    child: ButtonTheme(
                      minWidth: MediaQuery.of(context).size.width /3.2,
                      child: OutlineButton(
                        onPressed: (){validateInput();},

                        child: Text(
                          'Save',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        borderSide: BorderSide(color: Colors.black,width: 1.8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
