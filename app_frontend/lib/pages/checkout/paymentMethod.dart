import 'package:flutter/material.dart';

class PaymentMethod extends StatefulWidget {
  @override
  _PaymentMethodState createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
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
