import 'package:flutter/material.dart';

import 'package:app_frontend/pages/onBoardingScreen/slideTitle.dart';
import 'package:app_frontend/pages/onBoardingScreen/sliderModel.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<SliderModel> slides = new List<SliderModel>();
  int slideIndex = 0;
  PageController controller;

  Widget _buildPageIndicator(bool isCurrentPage){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      height: isCurrentPage ? 12.0 : 9.0,
      width: isCurrentPage ? 12.0 : 9.0,
      decoration: BoxDecoration(
        color: isCurrentPage ? Colors.grey: Colors.grey[300],
        borderRadius: BorderRadius.circular(12)
      ),
    );
  }

  buildSlides(){
    slides = getSlides();
    controller = new PageController();
  }

  @override
  Widget build(BuildContext context) {
    buildSlides();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Container(),
        title: GestureDetector(
          onTap: (){
            Navigator.of(context).pushReplacementNamed('/');
          },
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              'Skip',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.0,
                color: Colors.black
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        elevation: 8.0,
        child: Icon(
          Icons.keyboard_arrow_right,
          size: 35.0,
        ),
        onPressed: (){
          if(slideIndex != 5){
            controller.animateToPage(slideIndex + 1, duration: Duration(milliseconds: 500), curve: Curves.linear);
          }
          else{
            Navigator.of(context).pushReplacementNamed('/');
          }
        },
      ),
      body: Container(
        height: MediaQuery.of(context).size.height - 100,
        child: PageView(
          controller: this.controller,
          onPageChanged: (index){
            setState(() {
              slideIndex = index;
            });
          },
          children: <Widget>[
            SlideTile(
              imagePath: slides[0].getImageAssetPath(),
              title: slides[0].getTitle(),
              desc: slides[0].getDesc(),
            ),
            SlideTile(
              imagePath: slides[1].getImageAssetPath(),
              title: slides[1].getTitle(),
              desc: slides[1].getDesc(),
            ),
            SlideTile(
              imagePath: slides[2].getImageAssetPath(),
              title: slides[2].getTitle(),
              desc: slides[2].getDesc(),
            ),
            SlideTile(
              imagePath: slides[3].getImageAssetPath(),
              title: slides[3].getTitle(),
              desc: slides[3].getDesc(),
            ),
            SlideTile(
              imagePath: slides[4].getImageAssetPath(),
              title: slides[4].getTitle(),
              desc: slides[4].getDesc(),
            ),
            SlideTile(
              imagePath: slides[5].getImageAssetPath(),
              title: slides[5].getTitle(),
              desc: slides[5].getDesc(),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        margin: EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Row(
                children: [
                  for (int i = 0; i < 6 ; i++) i == slideIndex ? _buildPageIndicator(true): _buildPageIndicator(false),
                ]
              ),
            ),
          ],
        ),
      )
    );
  }
}