import 'dart:collection';
import 'package:flutter/material.dart';

import 'package:app_frontend/sizeConfig.dart';
import 'package:app_frontend/components/loader.dart';
import 'package:app_frontend/services/userService.dart';
import 'package:app_frontend/services/validateService.dart';
import 'package:app_frontend/components/alertBox.dart';
import 'package:app_frontend/components/modals/internetConnection.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  HashMap userValues = new HashMap<String, String>();
  Map customWidth = new Map<String,double>();

  double borderWidth = 2.0;

  ValidateService _validateService = ValidateService();
  UserService _userService = UserService();

  login() async{
    if(this._formKey.currentState.validate()){
      _formKey.currentState.save();

      bool connectionStatus = await _userService.checkInternetConnectivity();
      if(connectionStatus){
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
        internetConnectionDialog(context);
      }

    }
  }

  OutlineInputBorder setBorder(double width, Color color){
    return OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
        borderSide: BorderSide(
            width: width,
            color: color
        )
    );
  }

  InputDecoration customFormField(String text){
    return InputDecoration(
        hintText: text,
        labelText: text,
        prefixIcon: Icon(text == 'Password'? Icons.lock : Icons.email),
        contentPadding: EdgeInsets.all(customWidth['fieldPadding']),
        errorBorder: this.setBorder(1.8, Colors.red),
        focusedErrorBorder: this.setBorder(1.2, Colors.red),
        focusedBorder: this.setBorder(2.0, Colors.blue),
        enabledBorder: this.setBorder(1.0, Colors.white),
        fillColor: Colors.white,
        filled: true,
        errorStyle: TextStyle(
            fontSize: SizeConfig.safeBlockHorizontal * 3
        )
    );
  }

  customScreenWidth(String screen){
    switch(screen){
      case 'smallMobile':{
        customWidth['fieldPadding'] = 15.0;
        customWidth['formFieldSpacing'] = 16.0;
        customWidth['formTextSize'] = 14.0;
        customWidth['buttonWidth'] =160.0;
        break;
      }
      case 'largeMobile':{
        customWidth['fieldPadding'] = 24.0;
        customWidth['formFieldSpacing'] = 22.0;
        customWidth['formTextSize'] = 19.0;
        customWidth['buttonWidth'] =180.0;
        break;
      }
      case 'tablet':{
        customWidth['fieldPadding'] = 20.0;
        customWidth['formFieldSpacing'] = 29.0;
        customWidth['formTextSize'] = 25.0;
        customWidth['buttonWidth'] = 300.0;
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    customScreenWidth(SizeConfig.screenSize);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () => Navigator.popAndPushNamed(context, '/')
        ),
        iconTheme: IconThemeData(
          color: Colors.black
        ),
        backgroundColor: Colors.grey[200],
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: SizeConfig.safeBlockVertical,
              horizontal: SizeConfig.safeBlockHorizontal * 6
          ),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.disabled,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Sign In',
                  style: TextStyle(
                    fontSize: SizeConfig.safeBlockHorizontal * 10.5,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'NovaSquare'
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: SizeConfig.safeBlockVertical * 3,
                      horizontal: SizeConfig.safeBlockHorizontal * 4.8
                  ),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: customFormField('E-mail'),
                        validator: (value)=> _validateService.isEmptyField(value),
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (String val){
                          userValues['email'] = val;
                        },
                        style: TextStyle(
                          fontSize: customWidth['formTextSize']
                        ),
                      ),
                      SizedBox(height: customWidth['formFieldSpacing']),
                      TextFormField(
                        obscureText: true,
                        decoration: customFormField('Password'),
                        validator: (value) => _validateService.isEmptyField(value),
                        onSaved: (String val){
                          userValues['password'] = val;
                        },
                        style: TextStyle(
                            fontSize: customWidth['formTextSize']
                        ),
                      ),
                      SizedBox(height: 30.0),
                      Center(
                        child: Column(
                          children: <Widget>[
                            ButtonTheme(
                              minWidth: SizeConfig.screenWidth - customWidth['buttonWidth'],
                              child: FlatButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                    side: BorderSide(color: Colors.black)
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: SizeConfig.safeBlockVertical * 2.2
                                ),
                                color: Colors.black,
                                textColor: Colors.white,
                                child: Text(
                                  'Log in',
                                  style: TextStyle(
                                    fontFamily: 'NovaSquare',
                                    fontSize: SizeConfig.safeBlockHorizontal * 5.2,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.0
                                  ),
                                ),
                                onPressed: () {
                                  this.login();
                                },
                              ),
                            ),
                            SizedBox(height: SizeConfig.safeBlockVertical * 2.5),
                            Text(
                                'OR',
                              style: TextStyle(
                                fontSize: SizeConfig.safeBlockVertical * 3.6
                              ),
                            ),
                            SizedBox(height: SizeConfig.safeBlockVertical * 2.5),
                            ButtonTheme(
                              minWidth:  SizeConfig.screenWidth - customWidth['buttonWidth'],
                              child: FlatButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                    side: BorderSide(color: Colors.red)
                                ),
                                padding: EdgeInsets.symmetric(vertical: SizeConfig.safeBlockVertical * 2.2),
                                color: Colors.redAccent,
                                textColor: Colors.white,
                                child: Text(
                                  'Google Log in',
                                  style: TextStyle(
                                    fontFamily: 'NovaSquare',
                                    fontSize: SizeConfig.safeBlockHorizontal * 5.2,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
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