import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AlertBox extends StatelessWidget {
  String message;

  AlertBox(String message){
    this.message = message;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))
        ),
        contentPadding: EdgeInsets.all(0.0),
        content: Container(
          width: 200.0,
          height: 200.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 1.0),
              Text(
                'Alert',
                style: TextStyle(
                  fontSize: 26.0,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Divider(
                color: Colors.grey,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 0.0),
                child: Text(
                  this.message,
                  style: TextStyle(
                      fontSize: 23.0,
                      letterSpacing: 1.0
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.of(context).pop();
                },
                child: Container(
                  padding: EdgeInsets.only(top:20.0, bottom: 20.0),
                  decoration: BoxDecoration(
                    color: Colors.blue[800],
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16.0),
                        bottomRight: Radius.circular(16.0)
                    ),
                  ),
                  child: Text(
                    "Close",
                    style: TextStyle(
                        color: Colors.white
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        )
    );
  }
}
