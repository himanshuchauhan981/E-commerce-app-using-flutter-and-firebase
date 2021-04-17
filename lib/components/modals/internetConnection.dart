import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void internetConnectionDialog(BuildContext context) async{
  return showDialog(
    context: context,
    builder: (BuildContext context){
      return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0)
        ),
        child: Container(
          height: 300,
          // width: 100,
          child: Padding(
            padding: EdgeInsets.all(5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.signal_wifi_off,
                  size: 60.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text('Oops!',
                    style: TextStyle(
                      fontFamily: 'NovaSquare',
                      fontSize: 20.0,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'No internet connection found',
                    style: TextStyle(
                      fontSize: 20.0
                    ),
                  ),
                ),
                Text(
                  'Check your connection',
                  style: TextStyle(
                    fontSize: 20.0
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50.0,
                    child: ElevatedButton(
                      child: Text('Close',
                        style: TextStyle(
                          fontSize: 18.0
                        ),
                      ),
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.black),

                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }
  );
}