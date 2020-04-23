import 'dart:collection';
import 'package:flutter/material.dart';

import 'package:app_frontend/components/alertBox.dart';
import 'package:app_frontend/services/userService.dart';
import 'package:app_frontend/services/validateService.dart';


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

  signup() async {
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
        focusedBorder: this.setBorder(1.0, Colors.black),
        enabledBorder: this.setBorder(1.0, Colors.black)
    );
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
                        decoration: customFormField('First name'),
                        validator: (value) => validateService.isEmptyField(value),
                        onSaved: (String val){
                          userValues['firstName'] = val;
                        },
                      ),
                      SizedBox(height: 30.0),
                      TextFormField(
                        decoration: customFormField('Last name'),
                        validator: (value) => validateService.isEmptyField(value),
                        onSaved: (String val){
                          userValues['lastName'] = val;
                        },
                      ),
                      SizedBox(height: 30.0),
                      TextFormField(
                        decoration: customFormField('Phone number'),
                        keyboardType: TextInputType.phone,
                        validator: (value) => validateService.validatePhoneNumber(value),
                        onSaved: (String val){
                          userValues['mobileNumber'] = val;
                        },
                      ),
                      SizedBox(height: 30.0),
                      TextFormField(
                        decoration: customFormField('E-mail Address'),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) => validateService.validateEmail(value),
                        onSaved: (String val){
                          userValues['email'] = val;
                        },
                      ),
                      SizedBox(height: 30.0),
                      TextFormField(
                        obscureText: true,
                        decoration: customFormField('Password'),
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
