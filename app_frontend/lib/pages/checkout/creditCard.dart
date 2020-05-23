import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';

class AddCreditCard extends StatefulWidget {
  @override
  _AddCreditCardState createState() => _AddCreditCardState();
}

class _AddCreditCardState extends State<AddCreditCard> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName ='';
  String cvvCode = '';
  bool isCvvFocused = false;

  void onCreditCardModelChange(CreditCardModel creditCardModel){
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
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
            Text(
              'Next',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
              )
            )
          ],
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 10.0),
          child: Column(
            children: <Widget>[
              Text(
                'Add a Card',
                style: TextStyle(
                  fontSize: 35.0,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.bold
                ),
              ),
              CreditCardWidget(
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                showBackView: isCvvFocused,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: CreditCardForm(
                    onCreditCardModelChange: onCreditCardModelChange,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
