import 'dart:collection';
import 'package:app_frontend/services/userService.dart';
import 'package:flutter/material.dart';

import 'package:app_frontend/services/validateService.dart';
import 'package:http/http.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  bool _autoValidate = false;
  double borderWidth = 1.0;
  final _formKey = GlobalKey<FormState>();
  HashMap userValues = new HashMap<String,String>();

  ValidateService validateService = ValidateService();
  UserService userService = UserService();

  setBorder(double width, Color color){
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: BorderSide(
            width: width,
            color: color
        )
    );
  }

  createAlertDialog(BuildContext context,String message){
    return showDialog(
      context: context,
      builder: (BuildContext context){
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
                    message,
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
    );
  }


  signup() async {
    if(this._formKey.currentState.validate()){
      _formKey.currentState.save();
      Response response = await userService.signup(userValues);
      int statusCode = response.statusCode;
      if(statusCode == 400){
        this.createAlertDialog(context,response.body);
      }
      else{
        Navigator.pushReplacementNamed(context, '/');
      }
    }
    else{
      setState(() {
        _autoValidate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context,false),
        ),
        iconTheme: IconThemeData(
            color: Colors.black
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 15.0),
          child: Form(
            key: _formKey,
            autovalidate: _autoValidate,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Create new account',
                  style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 50.0),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                            hintText: 'First name',
                            contentPadding: EdgeInsets.all(20.0),
                            errorBorder: this.setBorder(1.0, Colors.red),
                            focusedErrorBorder: this.setBorder(1.0, Colors.red),
                            focusedBorder: this.setBorder(1.0, Colors.black),
                            enabledBorder: this.setBorder(1.0, Colors.black)
                        ),
                        validator: (value) => validateService.isEmptyField(value),
                        onSaved: (String val){
                          userValues['firstName'] = val;
                        },
                      ),
                      SizedBox(height: 30.0),
                      TextFormField(
                        decoration: InputDecoration(
                            hintText: 'Last name',
                            contentPadding: EdgeInsets.all(20.0),
                            errorBorder: this.setBorder(1.0, Colors.red),
                            focusedErrorBorder: this.setBorder(1.0, Colors.red),
                            focusedBorder: this.setBorder(1.0, Colors.black),
                            enabledBorder: this.setBorder(1.0, Colors.black)
                        ),
                        validator: (value) => validateService.isEmptyField(value),
                        onSaved: (String val){
                          userValues['lastName'] = val;
                        },
                      ),
                      SizedBox(height: 30.0),
                      TextFormField(
                        decoration: InputDecoration(
                            hintText: 'Phone number',
                            contentPadding: EdgeInsets.all(20.0),
                            errorBorder: this.setBorder(1.0, Colors.red),
                            focusedErrorBorder: this.setBorder(1.0, Colors.red),
                            focusedBorder: this.setBorder(1.0, Colors.black),
                            enabledBorder: this.setBorder(1.0, Colors.black)
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (value) => validateService.validatePhoneNumber(value),
                        onSaved: (String val){
                          userValues['mobileNumber'] = val;
                        },
                      ),
                      SizedBox(height: 30.0),
                      TextFormField(
                        decoration: InputDecoration(
                            hintText: 'E-mail Address',
                            contentPadding: EdgeInsets.all(20.0),
                            errorBorder: this.setBorder(1.0, Colors.red),
                            focusedErrorBorder: this.setBorder(1.0, Colors.red),
                            focusedBorder: this.setBorder(1.0, Colors.black),
                            enabledBorder: this.setBorder(1.0, Colors.black)
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) => validateService.validateEmail(value),
                        onSaved: (String val){
                          userValues['email'] = val;
                        },
                      ),
                      SizedBox(height: 30.0),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: 'Password',
                            contentPadding: EdgeInsets.all(20.0),
                            errorBorder: this.setBorder(1.0, Colors.red),
                            focusedErrorBorder: this.setBorder(1.0, Colors.red),
                            focusedBorder: this.setBorder(1.0, Colors.black),
                            enabledBorder: this.setBorder(1.0, Colors.black)
                        ),
                        validator: (value) => validateService.validatePassword(value),
                        onSaved: (String val){
                          userValues['password'] = val;
                        },
                      ),
                      SizedBox(height: 50.0),
                      ButtonTheme(
                        minWidth: 250.0,
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(36),
                              side: BorderSide(color: Colors.black)
                          ),
                          padding: EdgeInsets.symmetric(vertical: 20.0),
                          color: Colors.blue[800],
                          textColor: Colors.white,
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          onPressed: () {
                            this.signup();
                          },
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
