import 'dart:collection';
import 'package:flutter/material.dart';

import 'package:app_frontend/components/checkout/checkoutAppBar.dart';
import 'package:app_frontend/components/checkout/shippingAddressInput.dart';
import 'package:app_frontend/services/checkoutService.dart';

class ShippingAddress extends StatefulWidget {
  @override
  _ShippingAddressState createState() => _ShippingAddressState();
}

class _ShippingAddressState extends State<ShippingAddress> {
  final _formKey = GlobalKey<FormState>();
  bool autoValidate = false;
  bool visibleInput = false;
  int selectedAddress;
  int tempLength = 0;
  CheckoutService _checkoutService = new CheckoutService();
  HashMap addressValues = new HashMap();
  List shippingAddress = new List();

  saveNewAddress(){
    return Container(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: Column(
          children: <Widget>[
            Text(
              'No address saved',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            SizedBox(height: 20.0),
            ButtonTheme(
              minWidth: MediaQuery.of(context).size.width /3.2,
              child: OutlineButton(
                onPressed: (){
                  setState(() {
                    visibleInput = true;
                  });
                },
                child: Text(
                  'Add new',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold
                  ),
                ),
                borderSide: BorderSide(color: Colors.black,width: 1.8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
              ),
            )
          ],
        ),
      ),
    );
  }

  showSavedAddress(){
    return Container(
      child: Column(
        children: <Widget>[
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: shippingAddress.length,
            itemBuilder: (BuildContext context, int index) {
              var item = shippingAddress[index];
              return Card(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Icon(Icons.home),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            item['name'],
                            style: TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(height: 5.0),
                          Text(
                            item['address'],
                            style: TextStyle(
                                fontSize: 15.0
                            ),
                          ),
                          Text(
                            "${item['area']}, ${item['city']} ${item['pinCode']}",
                            style: TextStyle(
                                fontSize: 15.0
                            ),
                          ),
                          Text(
                            item['state'],
                            style: TextStyle(
                                fontSize: 15.0
                            ),
                          ),
                          Text(
                              "Phone number : ${item['mobileNumber']}"
                          )
                        ],
                      ),
                      Radio(
                        value: index,
                        groupValue: selectedAddress,
                        onChanged: (value) {
                          setState(() {
                            selectedAddress = index;
                          });
                        },
                      )
                    ],
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 10.0),
          ButtonTheme(
            minWidth: MediaQuery.of(context).size.width /3.2,
            child: OutlineButton(
              onPressed: (){
                setState(() {
                  visibleInput = true;
                });
              },
              child: Text(
                'Add new',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold
                ),
              ),
              borderSide: BorderSide(color: Colors.black,width: 1.8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
            ),
          )
        ],
      ),
    );
  }

  animateContainers(){
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 1000),
      transitionBuilder: (Widget child, Animation<double> animation){
        return ScaleTransition(child: child, scale: animation);
      },
      child: !visibleInput ? (shippingAddress.length == 0)? saveNewAddress():showSavedAddress() : ShippingAddressInput(addressValues, this.validateInput),
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

  listShippingAddress() async{
    List data = await _checkoutService.listShippingAddress();
    setState(() {
      shippingAddress = data;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listShippingAddress();
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
                  animateContainers()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
