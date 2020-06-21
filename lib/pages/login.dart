import 'dart:collection';
import 'package:flutter/material.dart';

import 'package:app_frontend/components/loader.dart';
import 'package:app_frontend/services/userService.dart';
import 'package:app_frontend/services/validateService.dart';
import 'package:app_frontend/components/alertBox.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  HashMap userValues = new HashMap<String, String>();
  bool _autoValidate = false;
  double borderWidth = 2.0;

  ValidateService _validateService = ValidateService();
  UserService _userService = UserService();

  login() async{
    if(this._formKey.currentState.validate()){
      _formKey.currentState.save();
      Loader.showLoadingScreen(context, _keyLoader);
      await _userService.login(userValues);
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      int statusCode = _userService.statusCode;
      if(statusCode == 200){
        Navigator.pushNamed(context, '/home');
      }
      else{
        AlertBox alertBox = AlertBox(_userService.msg);
        return showDialog(
          context: context,
          builder: (BuildContext context){
            return alertBox.build(context);
          }
        );
      }
    }
    else{
      setState(() {
        _autoValidate = true;
      });
    }
  }

  setBorder(double width, Color color){
    return OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
        borderSide: BorderSide(
            width: width,
            color: color
        )
    );
  }

  InputDecoration customFormField(String hintText){
    return InputDecoration(
        hintText: hintText,
        contentPadding: EdgeInsets.all(20.0),
        border: InputBorder.none,
        errorBorder: this.setBorder(borderWidth, Colors.red),
        focusedErrorBorder: this.setBorder(borderWidth, Colors.red),
        focusedBorder: this.setBorder(borderWidth, Colors.black),
        enabledBorder: this.setBorder(borderWidth, Colors.black)
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.popAndPushNamed(context, '/')
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
                  'Sign In',
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
                        decoration: customFormField('E-mail or Mobile number'),
                        validator: (value)=> _validateService.isEmptyField(value),
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (String val){
                          userValues['email'] = val;
                        }
                      ),
                      SizedBox(height: 30.0),
                      TextFormField(
                        obscureText: true,
                        decoration: customFormField('Password'),
                        validator: (value) => _validateService.isEmptyField(value),
                        onSaved: (String val){
                          userValues['password'] = val;
                        },
                      ),
                      SizedBox(height: 30.0),
                      Center(
                        child: Column(
                          children: <Widget>[
                            ButtonTheme(
                              minWidth: 250.0,
                              child: FlatButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(36),
                                    side: BorderSide(color: Colors.black)
                                ),
                                padding: EdgeInsets.symmetric(vertical: 20.0),
                                color: Colors.black,
                                textColor: Colors.white,
                                child: Text(
                                  'Log in',
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                onPressed: () {
                                  this.login();
                                },
                              ),
                            ),
                            SizedBox(height: 60.0),
                            Text(
                                'OR',
                              style: TextStyle(
                                fontSize: 20.0
                              ),
                            ),
                            SizedBox(height: 40.0),
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
                                  'Google Log in',
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ],
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