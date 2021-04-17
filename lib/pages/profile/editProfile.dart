import 'package:app_frontend/components/modals/internetConnection.dart';
import 'package:app_frontend/services/userService.dart';
import 'package:flutter/material.dart';

import 'package:app_frontend/components/sidebar.dart';
import 'package:app_frontend/components/header.dart';
import 'package:app_frontend/components/loader.dart';
import 'package:app_frontend/services/profileService.dart';
import 'package:app_frontend/services/validateService.dart';
import 'package:app_frontend/sizeConfig.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  ValidateService _validateService  = new ValidateService();
  ProfileService _profileService = new ProfileService();
  UserService _userService = new UserService();
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  bool showCartIcon = true;
  bool _autoValidate = false;
  String fullName, mobileNumber, email;

  setProfileDetails(){
    dynamic args = ModalRoute.of(context).settings.arguments;
    setState(() {
      fullName = args['fullName'];
      mobileNumber = args['mobileNumber'];
      email = args['email'];
    });
  }
  
  InputDecoration customFormField(text){
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      hintText: text,
      labelText: text,
      errorStyle: TextStyle(
        fontSize: SizeConfig.safeBlockHorizontal * 3.2
      ),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: BorderSide(
              width: 2.0,
              color: Colors.black
          )
      ),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: BorderSide(
              width: 2.0,
              color: Colors.black
          )
      ),
    );
  }

  validateProfile(context) async{
    if(this._formKey.currentState.validate()){
      _formKey.currentState.save();
      bool connectionStatus = await _userService.checkInternetConnectivity();

      if(connectionStatus){
        Loader.showLoadingScreen(context, _keyLoader);
        _profileService.updateAccountDetails(fullName, mobileNumber).then((value) async{
          Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
          Map userData = await _profileService.getUserProfile();
          Navigator.pushReplacementNamed(context, '/profile',arguments: userData);
        });
      }
      else{
        internetConnectionDialog(context);
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
    setProfileDetails();
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      key: _scaffoldKey,
      appBar: header('Edit Profile', _scaffoldKey, showCartIcon, context),
      drawer: sidebar(context),
      body: Container(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(10.0, 40.0, 10.0, 10.0),
                child: Text(
                  'PUBLIC PROFILE',
                  style: TextStyle(
                    fontFamily: 'NovaSquare',
                    fontSize: SizeConfig.safeBlockHorizontal * 5.2,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  SizeConfig.safeBlockHorizontal * 6,
                  0.0,
                  SizeConfig.safeBlockHorizontal * 6,
                  SizeConfig.safeBlockVertical * 4
                ),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: customFormField('Full name'),
                      initialValue: fullName,
                      validator: (value)=> _validateService.isEmptyField(value),
                      keyboardType: TextInputType.text,
                      onSaved: (String val) => fullName = val,
                      style: TextStyle(
                        fontSize: SizeConfig.safeBlockHorizontal * 4.2,
                        letterSpacing: 1.0
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                child: Text(
                  'PRIVATE PROFILE',
                  style: TextStyle(
                    fontFamily: 'NovaSquare',
                    fontSize: SizeConfig.safeBlockHorizontal * 5.2,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    SizeConfig.safeBlockHorizontal * 6,
                    0.0,
                    SizeConfig.safeBlockHorizontal * 6,
                    SizeConfig.safeBlockVertical * 4
                ),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: customFormField('E-mail address'),
                      initialValue: email,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value)=> _validateService.isEmptyField(value),
                      onSaved: (String value) => email = value,
                      style: TextStyle(
                          fontSize: SizeConfig.safeBlockHorizontal * 4.2,
                          letterSpacing: 1.0
                      ),
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: customFormField('Phone number'),
                      initialValue: mobileNumber,
                      validator: (value)=> _validateService.isEmptyField(value),
                      keyboardType: TextInputType.phone,
                      onSaved: (String value) => mobileNumber = value,
                      style: TextStyle(
                          fontSize: SizeConfig.safeBlockHorizontal * 4.2,
                          letterSpacing: 1.0
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey[200],
        elevation: 16,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: SizeConfig.safeBlockVertical * 3,
            horizontal: SizeConfig.safeBlockHorizontal * 8,
          ),
          child: ButtonTheme(
            padding: EdgeInsets.symmetric(
              horizontal: 0,
              vertical: SizeConfig.safeBlockVertical * 1.4
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(7.0)),
              side: BorderSide(color: Colors.black,width: 2.0)
            ),
            height: 50.0,
            child: RaisedButton(
              color: Colors.white,
              onPressed: (){
                validateProfile(context);
              },
              child: Text(
                'UPDATE',
                style: TextStyle(
                  fontFamily: 'NovaSquare',
                  fontSize: SizeConfig.safeBlockHorizontal * 4.6,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
