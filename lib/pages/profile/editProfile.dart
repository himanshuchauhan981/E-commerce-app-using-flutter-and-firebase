import 'dart:ffi';

import 'package:flutter/material.dart';

import 'package:app_frontend/components/header.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool showCartIcon = true;
  String firstName, lastName, mobileNumber, email;

  setProfileDetails(){
    dynamic args = ModalRoute.of(context).settings.arguments;
    setState(() {
      firstName = args['firstName'];
      lastName = args['lastName'];
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
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(
              width: 2.0,
              color: Colors.black
          )
      ),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(
              width: 2.0,
              color: Colors.black
          )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    setProfileDetails();
    return Scaffold(
      backgroundColor: Colors.grey[200],
      key: _scaffoldKey,
      appBar: header('Edit Profile', _scaffoldKey, showCartIcon, context),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(10.0, 40.0, 10.0, 10.0),
              child: Text(
                'PUBLIC PROFILE',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 40.0),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: customFormField('First name')
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: customFormField('Last name')
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
              child: Text(
                'PRIVATE PROFILE',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: customFormField('E-mail address')
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: customFormField('Phone number')
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey[200],
        elevation: 0,
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          child: ButtonTheme(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(7.0)),
              side: BorderSide(color: Colors.black,width: 2.0)
            ),
            minWidth: MediaQuery.of(context).size.width,
            height: 50.0,
            child: RaisedButton(
              color: Colors.white,
              onPressed: (){},
              child: Text(
                'UPDATE',
                style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
