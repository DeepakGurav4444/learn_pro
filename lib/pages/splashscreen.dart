import 'dart:async';
import 'package:learn_pro/pages/home/home.dart';
import 'package:flutter/material.dart';
import 'package:learn_pro/pages/onboarding/onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String _id;
  @override
  void initState() {
    checkLogin();
    Timer(
        Duration(seconds: 3),
        () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => _id == null ? OnBoarding() : Home(),
              ),
            ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: height,
        width: width,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.1),
          child: Center(
            child: Image.asset("assets/final-logo.png"),
          ),
        ),
      ),
    );
  }

  checkLogin() async {
    final pref = await SharedPreferences.getInstance();
    // ignore: await_only_futures
    _id = await pref.getString("id");
    print(_id);
  }
}
