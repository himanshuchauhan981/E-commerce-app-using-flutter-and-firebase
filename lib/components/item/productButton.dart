import 'package:app_frontend/sizeConfig.dart';
import 'package:flutter/material.dart';

class ProductButtons extends StatefulWidget {
  final void Function() addToShoppingBag;
  final void Function() checkoutProduct;

  ProductButtons(this.addToShoppingBag, this.checkoutProduct);

  @override
  _ProductButtonsState createState() => _ProductButtonsState();
}

class _ProductButtonsState extends State<ProductButtons> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ButtonTheme(
          padding: EdgeInsets.symmetric(vertical: SizeConfig.safeBlockVertical * 1.6),
          minWidth: SizeConfig.screenWidth / 2.7,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                elevation: 16.0,
                textStyle: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                widget.addToShoppingBag();
              },
              child: Text(
                'Add to bag',
                style: TextStyle(
                  fontSize: SizeConfig.safeBlockHorizontal * 5.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              )),
        ),
        ButtonTheme(
          minWidth: SizeConfig.screenWidth / 2.7,
          padding: EdgeInsets.symmetric(vertical: SizeConfig.safeBlockVertical * 1.6),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 16.0,
              textStyle: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: () {
              widget.checkoutProduct();
            },
            child: Text(
              'Pay',
              style: TextStyle(
                fontSize: SizeConfig.safeBlockHorizontal * 5.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
    );
  }
}
