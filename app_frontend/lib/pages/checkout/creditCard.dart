import 'package:app_frontend/services/creditCardFormatter.dart';
import 'package:app_frontend/services/creditCardValidation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  PaymentCard _paymentCard = new PaymentCard();
  GlobalKey _formKey = new GlobalKey<FormState>();
  bool autoValidate = false;
  String iconColorState = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _paymentCard.type = CardType.Others;
  }

  void validateCardDetails(){
    final FormState form = _formKey.currentState;
    if(!form.validate()){
      print('bye');
      setState(() {
        autoValidate = true;
      });
    }
  }

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
              'Cancel',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
              )
            ),
            GestureDetector(
              onTap: validateCardDetails,
              child: Text(
                'Next',
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
          padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 10.0),
          child: Form(
            key: _formKey,
            autovalidate: autoValidate,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Add a Card',
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
                        boxShadow: [BoxShadow(
                          color: Colors.black54,
                          blurRadius: 2.0,
                          spreadRadius: 0.0,
                          offset: Offset(2.0, 2.0), // shadow direction: bottom right
                        )],
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
                      inputFormatters: [
                        WhitelistingTextInputFormatter.digitsOnly,
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
                        WhitelistingTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(4),
                        CardMonthInputFormatter()
                      ],
                      validator: CreditCardValidation.validateDate,
                      onSaved: (value){
                        List<int> expiryDate = CreditCardValidation.getExpiryDate(value);
                        print(expiryDate);
                        _paymentCard.month = expiryDate[0];
                        _paymentCard.year = expiryDate[1];
                      },
                    ),
                  ),
                  ListTile(
                    leading: Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Image.asset(
                        'assets/cvv.png',
                        width: 26.0,
                        color: iconColorState == 'cvvCode'? Colors.black : Colors.grey,
                      ),
                    ),
                    title: TextFormField(
                      obscureText: true,
                      onTap: (){
                        setState(() {
                          iconColorState = 'cvvCode';
                        });
                      },
                      onChanged: (text){
                        setState(() {
                          if(text.length == 0) cvvCode = 'CVV/CVC';
                          else cvvCode = "*"*text.length;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'CVV'
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        WhitelistingTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(4)
                      ],
                      validator: CreditCardValidation.validateCVV,
                      onSaved: (value){
                        _paymentCard.cvv = int.parse(value);
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
                          print(text);
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
