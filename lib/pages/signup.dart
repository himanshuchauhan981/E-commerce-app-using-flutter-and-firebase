import 'dart:collection';
import 'package:flutter/material.dart';

import 'package:app_frontend/components/alertBox.dart';
import 'package:app_frontend/services/userService.dart';
import 'package:app_frontend/services/validateService.dart';


class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  bool _autoValidate = false;
  double borderWidth = 1.0;
  final _formKey = GlobalKey<FormState>();
  HashMap userValues = new HashMap<String,String>();

  ValidateService validateService = ValidateService();
  UserService userService = UserService();

  setBorder(double width, Color color){
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(
            width: width,
            color: color
        ),
    );
  }

  signUpUser() async {
    if(this._formKey.currentState.validate()){
      _formKey.currentState.save();
      await userService.signup(userValues);
      int statusCode = userService.statusCode;
      if(statusCode == 400){
        AlertBox alertBox = AlertBox(userService.msg);
        return showDialog(
          context: context,
          builder: (BuildContext context){
            return alertBox.build(context);
          }
        );
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

  InputDecoration customFormField(String hintText){
    return InputDecoration(
      hintText: hintText,
      contentPadding: EdgeInsets.all(20.0),
      errorBorder: this.setBorder(1.0, Colors.red),
      focusedErrorBorder: this.setBorder(1.0, Colors.red),
      focusedBorder: this.setBorder(2.0, Colors.blue),
      enabledBorder: this.setBorder(1.0, Colors.black),
      fillColor: Colors.white,
      filled: true,
      errorStyle: TextStyle(
        fontSize: 14,
        height: 0.6
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
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
          padding: EdgeInsets.symmetric(vertical: 30.0,horizontal: 20.0),
          child: Form(
            key: _formKey,
            autovalidate: _autoValidate,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    'Create new account',
                    style: TextStyle(
                      fontFamily: 'NovaSquare',
                      fontSize: 40.0
                    ),
                  ),
                ),
                SizedBox(height: 5),
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    'Sign up to get started',
                    style: TextStyle(
                      fontFamily: 'NovaSquare',
                      fontSize: 22.0,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: customFormField('First name'),
                        validator: (value) => validateService.isEmptyField(value),
                        onSaved: (String val){
                          userValues['firstName'] = val;
                        },
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      SizedBox(height: 15.0),
                      TextFormField(
                        decoration: customFormField('Last name'),
                        validator: (value) => validateService.isEmptyField(value),
                        onSaved: (String val){
                          userValues['lastName'] = val;
                        },
                        style: TextStyle(
                            fontSize: 18.0
                        ),
                      ),
                      SizedBox(height: 15.0),
                      TextFormField(
                        decoration: customFormField('Phone number'),
                        keyboardType: TextInputType.phone,
                        validator: (value) => validateService.validatePhoneNumber(value),
                        onSaved: (String val){
                          userValues['mobileNumber'] = val;
                        },
                        style: TextStyle(
                            fontSize: 18.0
                        ),
                      ),
                      SizedBox(height: 15.0),
                      TextFormField(
                        decoration: customFormField('E-mail Address'),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) => validateService.validateEmail(value),
                        onSaved: (String val){
                          userValues['email'] = val;
                        },
                        style: TextStyle(
                            fontSize: 18.0
                        ),
                      ),
                      SizedBox(height: 15.0),
                      TextFormField(
                        obscureText: true,
                        decoration: customFormField('Password'),
                        validator: (value) => validateService.validatePassword(value),
                        onSaved: (String val){
                          userValues['password'] = val;
                        },
                        style: TextStyle(
                            fontSize: 18.0
                        ),
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
                            this.signUpUser();
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
      )
    );
  }
}
