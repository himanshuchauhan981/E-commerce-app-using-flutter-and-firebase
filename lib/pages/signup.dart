import 'dart:collection';
import 'package:flutter/material.dart';

import 'package:app_frontend/components/alertBox.dart';
import 'package:app_frontend/services/userService.dart';
import 'package:app_frontend/services/validateService.dart';

import '../sizeConfig.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _autoValidate = false;
  double borderWidth = 1.0;
  final _signUpFormKey = GlobalKey<FormState>();
  HashMap userValues = new HashMap<String, String>();
  double fieldPadding;

  ValidateService validateService = ValidateService();
  UserService userService = UserService();

  setBorder(double width, Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(30.0),
      borderSide: BorderSide(width: width, color: color),
    );
  }

  signUpUser() async {
    if (this._signUpFormKey.currentState.validate()) {
      _signUpFormKey.currentState.save();
      await userService.signup(userValues);
      int statusCode = userService.statusCode;
      if (statusCode == 400) {
        AlertBox alertBox = AlertBox(userService.msg);
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              return alertBox.build(context);
            });
      } else {
        Navigator.pushReplacementNamed(context, '/');
      }
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  InputDecoration customFormField(String text) {
    return InputDecoration(
      hintText: text,
      labelText: text,
      prefixIcon: Icon(Icons.person),
      contentPadding: EdgeInsets.all(fieldPadding),
      errorBorder: this.setBorder(1.8, Colors.red),
      focusedErrorBorder: this.setBorder(1.2, Colors.red),
      focusedBorder: this.setBorder(2.0, Colors.blue),
      enabledBorder: this.setBorder(1.0, Colors.white),
      fillColor: Colors.white,
      filled: true,
    );
  }

  setUpFieldPadding(screen) {
    if (screen == 'smallMobile') {
      this.setState(() {
        fieldPadding = 10;
      });
    } else if (screen == 'largeMobile') {
      this.setState(() {
        fieldPadding = 20;
      });
    } else if (screen == 'tablet') {
      this.setState(() {
        fieldPadding = 26;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    setUpFieldPadding(SizeConfig.screenSize);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () => Navigator.pop(context, false),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.grey[200],
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: SizeConfig.safeBlockVertical / 2,
              horizontal: SizeConfig.safeBlockHorizontal * 10),
          child: Form(
            key: _signUpFormKey,
            autovalidate: _autoValidate,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Let's Get Started",
                  style: TextStyle(
                      fontFamily: 'NovaSquare',
                      fontSize: SizeConfig.safeBlockHorizontal * 8.0),
                ),
                Text(
                  'Create an account to get all features',
                  style: TextStyle(
                    fontFamily: 'NovaSquare',
                    fontSize: SizeConfig.safeBlockHorizontal * 3.8,
                    color: Colors.grey[800],
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: SizeConfig.safeAreaVertical * 0.8),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: this.customFormField('Full name'),
                        validator: (value) =>
                            validateService.isEmptyField(value),
                        onSaved: (String val) {
                          userValues['fullName'] = val;
                        },
                      ),
                      SizedBox(height: 13),
                      TextFormField(
                        decoration: this.customFormField('Mobile number'),
                        keyboardType: TextInputType.phone,
                        validator: (value) =>
                            validateService.validatePhoneNumber(value),
                        onSaved: (String val) {
                          userValues['mobileNumber'] = val;
                        },
                      ),
                      SizedBox(height: 13),
                      TextFormField(
                        decoration: this.customFormField('Email'),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) =>
                            validateService.validateEmail(value),
                        onSaved: (String val) {
                          userValues['email'] = val;
                        },
                      ),
                      SizedBox(height: 13),
                      TextFormField(
                        decoration: this.customFormField('Password'),
                        obscureText: true,
                        validator: (value) =>
                            validateService.validatePassword(value),
                        onSaved: (String val) {
                          userValues['password'] = val;
                        },
                      ),
                      SizedBox(height: 13),
                      ButtonTheme(
                        minWidth: SizeConfig.screenWidth - 140,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(36),
                              side: BorderSide(color: Colors.black)),
                          padding: EdgeInsets.symmetric(vertical: 12.0),
                          color: Colors.black87,
                          textColor: Colors.white,
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                                fontFamily: 'NovaSquare',
                                fontSize: SizeConfig.safeBlockHorizontal * 6.0,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            this.signUpUser();
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
