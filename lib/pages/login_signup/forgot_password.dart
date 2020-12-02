import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:learn_pro/appTheme/appTheme.dart';
import 'package:learn_pro/pages/home/home.dart';
import 'package:url_launcher/url_launcher.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    nestedAppBar() {
      return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 180,
              pinned: true,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  padding: EdgeInsets.all(20.0),
                  alignment: Alignment.bottomLeft,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/appbar_bg.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Text(
                    'Forgot Password',
                    style: TextStyle(
                      fontFamily: 'Signika Negative',
                      fontWeight: FontWeight.w700,
                      fontSize: 25.0,
                    ),
                  ),
                ),
              ),
              automaticallyImplyLeading: false,
            ),
          ];
        },
        body: ListView(
          children: <Widget>[
            SizedBox(height: 30.0),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(right: 30.0, left: 30.0),
              child: Column(
                children: <Widget>[
                  // Text(
                  //   'Enter your registered email to forgot your password',
                  //   style: TextStyle(
                  //     fontSize: 13.0,
                  //     fontFamily: 'Signika Negative',
                  //     color: Colors.grey[500],
                  //   ),
                  // ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.heartBroken,
                          color: Colors.grey,
                          size: 60.0,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          'Password should be reset from website',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18.0,
                            fontFamily: 'Signika Negative',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Center(
                          child: RichText(
                            text: TextSpan(
                                text: 'Visit to change password ',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.grey,
                                  fontSize: 18.0,
                                  fontFamily: 'Signika Negative',
                                  fontWeight: FontWeight.w700,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    launch(
                                        'https://studeebee.in/user/forget-password');
                                  }),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                  // SizedBox(height: 20.0),
                  // TextField(
                  //   decoration: InputDecoration(
                  //     hintText: 'Enter registered email',
                  //     hintStyle: TextStyle(
                  //       fontFamily: 'Signika Negative',
                  //       color: Colors.grey[500],
                  //     ),
                  //     contentPadding:
                  //         const EdgeInsets.only(top: 12.0, bottom: 12.0),
                  //   ),
                  // ),
                  // SizedBox(height: 40.0),
                  // InkWell(
                  //   onTap: () {
                  //     Navigator.push(context,
                  //         MaterialPageRoute(builder: (context) => Home()));
                  //   },
                  //   child: Container(
                  //     padding: EdgeInsets.all(15.0),
                  //     alignment: Alignment.center,
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(5.0),
                  //       color: textColor,
                  //     ),
                  //     child: Text(
                  //       'Forgot Password',
                  //       style: TextStyle(
                  //         fontFamily: 'Signika Negative',
                  //         fontSize: 18.0,
                  //         fontWeight: FontWeight.w700,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: nestedAppBar(),
    );
  }
}
