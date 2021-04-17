import 'package:flutter/material.dart';

import 'package:app_frontend/sizeConfig.dart';

class SlideTile extends StatelessWidget {
  final String imagePath, title, desc;

  SlideTile({this.imagePath, this.title, this.desc});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.safeBlockHorizontal * 2.4,
        vertical: SizeConfig.safeBlockVertical * 4,
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            imagePath,
            height: SizeConfig.safeBlockVertical * 20,
          ),
          SizedBox(
            height: SizeConfig.safeBlockVertical * 2,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'NovaSquare',
              fontWeight: FontWeight.bold,
              fontSize: SizeConfig.safeBlockVertical * 6,
              letterSpacing: 1.0
            ),
          ),
          SizedBox(
            height: SizeConfig.safeBlockVertical * 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(
              desc,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'NovaSquare',
                fontWeight: FontWeight.w500,
                fontSize: SizeConfig.safeBlockVertical * 3
              ),
            ),
          )
        ],
      ),
    );
  }
}
