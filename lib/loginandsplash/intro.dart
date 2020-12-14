import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utilities/styles.dart';
import 'package:http/http.dart' as http;

import 'auth_screen.dart';
import 'login_screen.dart';
import 'login_screen.dart';
import 'login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  Future<Post> post;
  @override
  void initState() {
    super.initState();
    post = fetchPost();
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Color(0xFF7B51D3),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.1, 0.4, 0.7, 0.9],
              colors: [
                Color(0xFF3594DD),
                Color(0xFF4563DB),
                Color(0xFF5036D5),
                Color(0xFF5B16D0),
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () => print('Skip'),
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
                FutureBuilder<Post>(
                  future: post,
                  builder: (context, abc) {
                    if (abc.hasData) {
                      return Container(
                        height: 600.0,
                        child: PageView(
                          physics: ClampingScrollPhysics(),
                          controller: _pageController,
                          onPageChanged: (int page) {
                            setState(() {
                              _currentPage = page;
                            });
                          },
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(40.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Center(
                                    child: Image(
                                      image: AssetImage(
                                        'assets/images/onboarding0.png',
                                      ),
                                      height: 300.0,
                                      width: 300.0,
                                    ),
                                  ),
                                  SizedBox(height: 30.0),
                                  Text(
                                    abc.data.headingSlide1,
                                    style: kTitleStyle,
                                  ),
                                  SizedBox(height: 15.0),
                                  Text(
                                    abc.data.textSlide1,
                                    style: kSubtitleStyle,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(40.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Center(
                                    child: Image(
                                      image: AssetImage(
                                        'assets/images/onboarding1.png',
                                      ),
                                      height: 300.0,
                                      width: 300.0,
                                    ),
                                  ),
                                  SizedBox(height: 30.0),
                                  Text(
                                    abc.data.headingSlide2,
                                    style: kTitleStyle,
                                  ),
                                  SizedBox(height: 15.0),
                                  Text(
                                    abc.data.textSlide2,
                                    style: kSubtitleStyle,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(40.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Center(
                                    child: Image(
                                      image: AssetImage(
                                        'assets/images/onboarding2.png',
                                      ),
                                      height: 300.0,
                                      width: 300.0,
                                    ),
                                  ),
                                  SizedBox(height: 30.0),
                                  Text(
                                    abc.data.headingSlide3,
                                    style: kTitleStyle,
                                  ),
                                  SizedBox(height: 15.0),
                                  Text(
                                    abc.data.textSlide3,
                                    style: kSubtitleStyle,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    } else if (abc.hasError) {
                      return Text("${abc.error}");
                    }

                    // By default, it show a loading spinner.
                    return CircularProgressIndicator();
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
                _currentPage != _numPages - 1
                    ? Expanded(
                        child: Align(
                          alignment: FractionalOffset.bottomRight,
                          child: FlatButton(
                            onPressed: () {
                              _pageController.nextPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease,
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  'Next',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22.0,
                                  ),
                                ),
                                SizedBox(width: 10.0),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: 30.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Text(''),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: _currentPage == _numPages - 1
          ? Container(
              height: 100.0,
              width: double.infinity,
              color: Colors.white,
              child: GestureDetector(
                onTap: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AuthScreen()))
                },
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 30.0),
                    child: Text(
                      'Get started',
                      style: TextStyle(
                        color: Color(0xFF5B16D0),
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            )
          : Text(''),
    );
  }
}

Future<Post> fetchPost() async {
  final response =
      await http.get('http://manage.doctorjiyo.com/api/IntroSlidesAPI');

  if (response.statusCode == 200) {
    // If the call to the server was successful (returns OK), parse the JSON.
    return Post.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful (response was unexpected), it throw an error.
    throw Exception('Failed to load post');
  }
}

class Post {
  String success;
  String iconSlide1;
  String iconSlide2;
  String iconSlide3;
  String headingSlide1;
  String headingSlide2;
  String headingSlide3;
  String textSlide1;
  String textSlide2;
  String textSlide3;
  String bgColorSlide1;
  String bgColorSlide2;
  String bgColorSlide3;

  Post(
      {this.success,
      this.iconSlide1,
      this.iconSlide2,
      this.iconSlide3,
      this.headingSlide1,
      this.headingSlide2,
      this.headingSlide3,
      this.textSlide1,
      this.textSlide2,
      this.textSlide3,
      this.bgColorSlide1,
      this.bgColorSlide2,
      this.bgColorSlide3});

  Post.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    iconSlide1 = json['IconSlide1'];
    iconSlide2 = json['IconSlide2'];
    iconSlide3 = json['IconSlide3'];
    headingSlide1 = json['HeadingSlide1'];
    headingSlide2 = json['HeadingSlide2'];
    headingSlide3 = json['HeadingSlide3'];
    textSlide1 = json['TextSlide1'];
    textSlide2 = json['TextSlide2'];
    textSlide3 = json['TextSlide3'];
    bgColorSlide1 = json['BgColorSlide1'];
    bgColorSlide2 = json['BgColorSlide2'];
    bgColorSlide3 = json['BgColorSlide3'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['IconSlide1'] = this.iconSlide1;
    data['IconSlide2'] = this.iconSlide2;
    data['IconSlide3'] = this.iconSlide3;
    data['HeadingSlide1'] = this.headingSlide1;
    data['HeadingSlide2'] = this.headingSlide2;
    data['HeadingSlide3'] = this.headingSlide3;
    data['TextSlide1'] = this.textSlide1;
    data['TextSlide2'] = this.textSlide2;
    data['TextSlide3'] = this.textSlide3;
    data['BgColorSlide1'] = this.bgColorSlide1;
    data['BgColorSlide2'] = this.bgColorSlide2;
    data['BgColorSlide3'] = this.bgColorSlide3;
    return data;
  }
}
