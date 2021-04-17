import 'package:app_frontend/components/modals/internetConnection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:app_frontend/services/userService.dart';
import 'package:app_frontend/sizeConfig.dart';

class Start extends StatelessWidget{
  final UserService _userService = new UserService();

  validateToken(context) async{
    bool connectionStatus = await _userService.checkInternetConnectivity();

    if(connectionStatus) {
      await Firebase.initializeApp();
      final storage = new FlutterSecureStorage();
      String value = await storage.read(key: 'idToken');
      if (value != null) {
        String decodedToken = _userService.validateToken(value);
        if (decodedToken != null) {
          Navigator.of(context).pushReplacementNamed('/home');
        }
        else {
          Navigator.of(context).pushReplacementNamed('/login');
        }
      }
      else {
        Navigator.of(context).pushReplacementNamed('/login');
      }
    }
    else{
      internetConnectionDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: SizeConfig.safeBlockVertical * 8),
                Image.asset('assets/sIcon.png', height: SizeConfig.safeBlockVertical * 20),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 0.0),
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                        'Welcome to Shop Mart',
                        style: TextStyle(
                          fontSize: SizeConfig.safeBlockHorizontal * 8,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'NovaSquare',
                        )
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: SizeConfig.safeBlockVertical * 3,
                    horizontal: SizeConfig.safeBlockHorizontal * 12.5,
                  ),
                  child: Text(
                    'Shop & get updates on new Products and sales with our mobile app',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'NovaSquare',
                      fontSize: SizeConfig.safeBlockHorizontal * 4.6,
                      letterSpacing: 1.0
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 5),
                  child: ButtonTheme(
                    minWidth: SizeConfig.screenWidth - 180,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)
                      ),
                      padding: EdgeInsets.symmetric(vertical: SizeConfig.safeBlockVertical * 3),
                      color: Colors.black,
                      textColor: Colors.white,
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontFamily: 'NovaSquare',
                          fontSize: SizeConfig.safeBlockHorizontal * 4.5,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                      onPressed: () {
                        validateToken(context);
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 3.0),
                  child: ButtonTheme(
                    minWidth: SizeConfig.screenWidth - 180,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                        side: BorderSide(color: Colors.black,width: 2.6)
                      ),
                      padding: EdgeInsets.symmetric(vertical: SizeConfig.safeBlockVertical * 3),
                      color: Colors.white,
                      textColor: Colors.black,
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          fontFamily: 'NovaSquare',
                          fontSize: SizeConfig.safeBlockHorizontal * 4.5,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                    ),
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}
