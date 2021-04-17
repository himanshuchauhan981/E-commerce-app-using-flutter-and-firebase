import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:app_frontend/components/checkout/checkoutAppBar.dart';
import 'package:app_frontend/services/checkoutService.dart';
import 'package:app_frontend/services/creditCardFormatter.dart';
import 'package:app_frontend/services/creditCardValidation.dart';
import 'package:app_frontend/components/modals/internetConnection.dart';
import 'package:app_frontend/services/userService.dart';

class AddCreditCard extends StatefulWidget {
  @override
  _AddCreditCardState createState() => _AddCreditCardState();
}

class _AddCreditCardState extends State<AddCreditCard> {
  String cardNumber = 'XXXX XXXX XXXX XXXX';
  String expiryDate = 'MM/YY';
  String cardHolderName ='CardHolder name';
  String cvvCode = 'CVV/CVC';
  bool isCvvFocused = false;
  bool autoValidate = false;
  String iconColorState = "";

  PaymentCard _paymentCard = new PaymentCard();
  CheckoutService _checkoutService = new CheckoutService();
  UserService _userService = new UserService();
  GlobalKey _formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _paymentCard.type = CardType.Others;
  }

  void addNewCard() async{
    bool connectionStatus = await _userService.checkInternetConnectivity();

    if(connectionStatus){
      final FormState form = _formKey.currentState;
      if(form.validate()){
        await _checkoutService.newCreditCardDetails(cardNumber, expiryDate, cardHolderName);
        Navigator.of(context).pushNamed('/checkout/paymentMethod');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CheckoutAppBar('Cancel','Next',this.addNewCard),
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
                    'Add new Card',
                    style: TextStyle(
                      fontSize: 35.0,
                      letterSpacing: 1.0,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 20.0),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black54,
                            blurRadius: 2.0,
                            spreadRadius: 0.0,
                            offset: Offset(2.0, 2.0),
                          )
                        ],
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black54,
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              cardNumber,
                              style: TextStyle(
                                fontSize: 24.0,
                                color: Colors.white
                              ),
                            ),
                            SizedBox(height: 100.0),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    expiryDate,
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.white
                                    ),
                                  ),
                                  Text(
                                    cvvCode,
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.white
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Text(
                              cardHolderName,
                              style: TextStyle(
                                  fontSize: 22.0,
                                  color: Colors.white
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Icon(
                        Icons.credit_card,
                        color: iconColorState == 'cardNumber'? Colors.black : Colors.grey,
                      ),
                    ),
                    title: TextFormField(
                      onTap: (){
                        setState(() {
                          iconColorState = 'cardNumber';
                        });
                      },
                      onChanged: (text){
                        setState(() {
                          if(text.length == 0) cardNumber = 'XXXX XXXX XXXX XXXX';
                          else cardNumber = text;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Card Number'
                      ),
                      keyboardType: TextInputType.number,
                      validator: CreditCardValidation.validateCardNumber,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(16),
                        CardNumberInputFormatter()
                      ],
                    ),
                  ),
                  ListTile(
                    leading: Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Icon(
                        Icons.calendar_today,
                        color: iconColorState == 'expiryDate'? Colors.black : Colors.grey,
                      ),
                    ),
                    title: TextFormField(
                      onTap: (){
                        setState(() {
                          iconColorState = 'expiryDate';
                        });
                      },
                      onChanged: (text){
                        setState(() {
                          if(text.length == 0) expiryDate = 'MM/YY';
                          else expiryDate = text;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Expiry Date'
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(4),
                        CardMonthInputFormatter()
                      ],
                      validator: CreditCardValidation.validateDate,
                      onSaved: (value){
                        List<int> expiryDate = CreditCardValidation.getExpiryDate(value);
                        _paymentCard.month = expiryDate[0];
                        _paymentCard.year = expiryDate[1];
                      },
                    ),
                  ),
                  ListTile(
                    leading: Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Icon(
                        Icons.person,
                        color: iconColorState == 'cardHolderName'? Colors.black : Colors.grey,
                      ),
                    ),
                    title: TextFormField(
                      onTap: (){
                        setState(() {
                          iconColorState = 'cardHolderName';
                        });
                      },
                      onChanged: (text){
                        setState(() {
                          if(text.length == 0) cardHolderName = 'CardHolder name';
                          else cardHolderName = text;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Card Name'
                      ),
                      keyboardType: TextInputType.text,
                      validator: (String value) => value.isEmpty ? ErrorString.reqField : null,
                      onSaved: (String value){
                        _paymentCard.name = value;
                      },
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
