import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loader{
  static Future<void> showLoadingScreen(BuildContext context, GlobalKey key) async{
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return new WillPopScope(
          onWillPop: () async => false,
          child: Container(
            key: key,
            child: SpinKitFoldingCube(
              color: Colors.green,
              size: 50.0,
            ),
          )
        );
      }
    );
  }
}