import 'dart:async';
import 'package:learn_pro/pages/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:learn_pro/appTheme/appTheme.dart';
import 'package:learn_pro/pages/onboarding/onboarding.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String _id;
  final storage = new FlutterSecureStorage();
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
      backgroundColor: const Color(0xFFF5F5F5),
      body: Container(
        height: height,
        width: width,
        color: textColor,
        child: Center(
          child: Text(
            'Welcome!',
            style: TextStyle(
              fontFamily: 'Signika Negative',
              fontSize: 60.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  checkLogin() async {
    _id = await storage.read(key: "id");
    print(_id);
  }
}
