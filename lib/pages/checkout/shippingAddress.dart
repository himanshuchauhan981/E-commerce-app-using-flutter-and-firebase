import 'dart:collection';
import 'package:app_frontend/services/userService.dart';
import 'package:flutter/material.dart';

import 'package:app_frontend/components/checkout/checkoutAppBar.dart';
import 'package:app_frontend/components/checkout/shippingAddressInput.dart';
import 'package:app_frontend/services/checkoutService.dart';
import 'package:app_frontend/components/modals/internetConnection.dart';

class ShippingAddress extends StatefulWidget {
  @override
  _ShippingAddressState createState() => _ShippingAddressState();
}

class _ShippingAddressState extends State<ShippingAddress> {
  final _formKey = GlobalKey<FormState>();
  bool autoValidate = false;
  bool visibleInput = false;
  int selectedAddress;
  CheckoutService _checkoutService = new CheckoutService();
  UserService _userService = new UserService();
  HashMap addressValues = new HashMap();
  List shippingAddress = new List();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  checkoutAddress(){

    if(selectedAddress == null){
      String msg = 'Select any address';
      showInSnackBar(msg, Colors.red);
    }
    else{
      Map<String,dynamic> args = ModalRoute.of(context).settings.arguments;

      args['shippingAddress'] = shippingAddress[selectedAddress];
      Navigator.of(context).pushNamed('/checkout/shippingMethod', arguments: args);
    }
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

  validateInput() async{
    bool connectionStatus = await _userService.checkInternetConnectivity();

    if(connectionStatus){
      if(_formKey.currentState.validate()){
        _formKey.currentState.save();
        await _checkoutService.newShippingAddress(addressValues);
        String msg = 'Address is saved';
        showInSnackBar(msg, Colors.black);
        setState(() {
          visibleInput = !visibleInput;
          shippingAddress.add(addressValues);
        });
      }
      else{
        setState(() {
          autoValidate = true;
        });
      }
    }
    else{
      internetConnectionDialog(context);
    }
  }

  listShippingAddress() async{
    bool connectionStatus = await _userService.checkInternetConnectivity();

    if(connectionStatus){
      List data = await _checkoutService.listShippingAddress();
      setState(() {
        shippingAddress = data;
      });
    }
    else{
      internetConnectionDialog(context);
    }
  }

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
                            "${item['area']}, ${item['city']}",
                            style: TextStyle(
                                fontSize: 15.0
                            ),
                          ),
                          Text(
                            "${item['state']} ${item['pinCode']}",
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listShippingAddress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CheckoutAppBar('Back','Next',this.checkoutAddress),
      body: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 10.0),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Shipping',
                    style: TextStyle(
                      fontFamily: 'NovaSquare',
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
                      fontFamily: 'NovaSquare',
                      fontSize: 28.0,
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
