import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final _formKey = GlobalKey<FormState>();

  login(){
    if(this._formKey.currentState.validate()){
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Processing Data')));
    }
  }

  setBorder(double width, Color color){
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
      borderSide: BorderSide(
        width: width,
        color: color
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    double borderWidth = 2.0;
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
                        decoration: InputDecoration(
                          hintText: 'E-mail or Mobile number',
                          contentPadding: EdgeInsets.all(20.0),
                          errorBorder: this.setBorder(borderWidth, Colors.red),
                          focusedBorder: this.setBorder(borderWidth, Colors.black),
                          enabledBorder: this.setBorder(borderWidth, Colors.black),
                        ),
                        validator: (value){
                          if(value.isEmpty){
                            return 'Required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 30.0),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: 'Password',
                            contentPadding: EdgeInsets.all(20),
                            errorBorder: this.setBorder(borderWidth, Colors.red),
                            focusedBorder: this.setBorder(borderWidth, Colors.black),
                            enabledBorder: this.setBorder(borderWidth, Colors.black),
                        ),
                        validator: (value){
                          if(value.isEmpty){
                            return 'Required';
                          }
                          return null;
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