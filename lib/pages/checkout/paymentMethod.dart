import 'package:app_frontend/components/checkout/checkoutAppBar.dart';
import 'package:app_frontend/services/checkoutService.dart';
import 'package:flutter/material.dart';

class PaymentMethod extends StatefulWidget {
  @override
  _PaymentMethodState createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  CheckoutService _checkoutService = new CheckoutService();
  List<String> cardNumberList = new List<String>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String selectedPaymentCard;

  checkoutPaymentMethod(){
    if(selectedPaymentCard != null){
      Map<String,dynamic> args = ModalRoute.of(context).settings.arguments;
      args['selectedCard'] = selectedPaymentCard;
      Navigator.pushNamed(context, '/placeOrder',arguments: args);
    }
    else{
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          backgroundColor: Colors.black,
          content: new Text('Select any address'),
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
  }

  listPaymentMethod() async{
    List data = await _checkoutService.listCreditCardDetails();
    setState(() {
      cardNumberList = data;
    });
  }

  showSavedCreditCard(){
    return Container(
      child: Column(
        children: <Widget>[
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: cardNumberList.length,
            itemBuilder: (BuildContext context, int index){
              var item = cardNumberList[index];
              return CheckboxListTile(
                secondary: Icon(Icons.credit_card),
                title: Text('Visa Ending with $item'),
                onChanged: (value){
                  setState(() {
                    selectedPaymentCard = item;
                  });
                },
                value: selectedPaymentCard == item,
              );
            },
          )
        ],
      ),
    );
  }

  animatePaymentContainers(){
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 1000),
      transitionBuilder: (Widget child, Animation<double> animation){
        return ScaleTransition(child: child, scale: animation);
      },
      child: cardNumberList.length != 0 ? showSavedCreditCard(): Text('No carf found')
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
                    size: 200.0,
                  )
                ),
              ),
              animatePaymentContainers(),
              SizedBox(height: 20.0),
              GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, '/addCreditCard');
                },
                child: ListTile(
                  leading: Icon(Icons.add),
                  title: Text('Add new Card'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
