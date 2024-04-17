import 'dart:io';

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../pages/homepage.dart';
import './introscreens/intro_page_1.dart';
import './introscreens/intro_page_2.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController _controller = PageController();
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        PageView(
          controller: _controller,
          onPageChanged: (index) {
            setState(() {
              onLastPage = (index == 1);
            });
          },
          children: [
            IntroPage1(),
            IntroPage2(),
          ],
        ),
        Container(
          alignment: Alignment(0, 0.9),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                  onTap: () {
                    exit(0);
                  },
                  child: Text('Exit',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ))),
              SmoothPageIndicator(
                controller: _controller,
                count: 2,
                effect: SlideEffect(
                    dotColor: const Color.fromARGB(255, 67, 62, 62),
                    activeDotColor: Colors.deepPurple),
              ),
              onLastPage
                  ? GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return MyHomePage();
                        }));
                      },
                      child: Text('Agree',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          )))
                  : GestureDetector(
                      onTap: () {
                        _controller.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                        );
                      },
                      child: Text('Next',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ))),
            ],
          ),
        ),
      ],
    ));
  }
}
