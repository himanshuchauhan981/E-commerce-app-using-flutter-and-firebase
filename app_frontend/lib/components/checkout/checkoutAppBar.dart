import 'package:flutter/material.dart';

class CheckoutAppBar extends StatefulWidget with PreferredSizeWidget {
  final String leftButtonText;
  final String rightButtonText;

  CheckoutAppBar(this.leftButtonText, this.rightButtonText);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  _CheckoutAppBarState createState() => _CheckoutAppBarState();
}

class _CheckoutAppBarState extends State<CheckoutAppBar> {


  @override
  Widget build(BuildContext context) {
    return Container(
      child: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              child: Text(
                widget.leftButtonText,
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                ),
              ),
            ),
            GestureDetector(
              child: Text(
                  widget.rightButtonText,
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                  )
              ),
            )
          ],
        ),
      ),
    );
  }
}

