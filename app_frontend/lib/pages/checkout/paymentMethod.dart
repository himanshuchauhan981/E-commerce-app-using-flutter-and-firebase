import 'package:app_frontend/components/checkout/checkoutAppBar.dart';
import 'package:app_frontend/pages/checkout/addCreditCard.dart';
import 'package:app_frontend/services/checkoutService.dart';
import 'package:flutter/material.dart';

class PaymentMethod extends StatefulWidget {
  @override
  _PaymentMethodState createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  CheckoutService _checkoutService = new CheckoutService();
  List<String> cardNumberList;

  checkoutPaymentMethod(){ }

  listPaymentMethod() async{
    List data = await _checkoutService.listCreditCardDetails();
    setState(() {
      cardNumberList = data;
    });
  }

  saveNewCardDetails(){ }

  showSavedCreditCard(){}

  animatePaymentContainers(){
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 1000),
      transitionBuilder: (Widget child, Animation<double> animation){
        return ScaleTransition(child: child, scale: animation);
      },
//      child: cardNumberList.length != 0 ? save,
    );
  }

  @override
  void initState() {
    super.initState();
    listPaymentMethod();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CheckoutAppBar('Cancel','Next',this.checkoutPaymentMethod),
      body: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Payment Method',
                style: TextStyle(
                    fontSize: 35.0,
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.bold
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 30.0),
                child: Center(
                  child: Icon(
                    Icons.credit_card,
                    size: 250.0,
                  )
                ),
              ),
              animatePaymentContainers(),
              ListTile(
                leading: Icon(Icons.credit_card),
                title: Text('Apple Pay'),
              ),
              ListTile(
                leading: Icon(Icons.credit_card),
                title: Text('Visa Ending in 4242'),
              ),
              ListTile(
                leading: Icon(Icons.credit_card),
                title: Text('Visa Ending in 4242'),
              ),
              SizedBox(height: 20.0),
              ListTile(
                leading: Icon(Icons.add),
                title: Text('Add new Card'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
