import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:learn_pro/appTheme/appTheme.dart';
import 'package:learn_pro/pages/home/home.dart';
import 'package:learn_pro/pages/login_signup/otp_screen.dart';
import 'package:learn_pro/services/networkHandler.dart';
import 'package:page_transition/page_transition.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final storage = new FlutterSecureStorage();
  //Network Handler Object
  NetworkHandler networkHandler = NetworkHandler();

  //FormKey for validation
  final registerFormKey = GlobalKey<FormState>();
  //Controllers for Validations
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  // Initially password is obscure
  bool _obscureText = true;
  bool _obscureConfirmText = true;

  // Toggles the password show status
  void _viewPassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  // Toggles the confirm password show status
  void _viewConfirmPassword() {
    setState(() {
      _obscureConfirmText = !_obscureConfirmText;
    });
  }

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
                    'Sign up',
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
        body: Form(
          key: registerFormKey,
          child: ListView(
            children: <Widget>[
              SizedBox(height: 30.0),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(right: 30.0, left: 30.0),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      keyboardType: TextInputType.text,
                      validator: (String val) {
                        if (val.isEmpty) {
                          return "field can't be empty";
                        } else if (val.length < 4) {
                          return "username should have at least four characters";
                        }
                      },
                      controller: _usernameController,
                      decoration: InputDecoration(
                        hintText: 'Username',
                        hintStyle: TextStyle(
                          fontFamily: 'Signika Negative',
                          color: Colors.grey[500],
                        ),
                        contentPadding:
                            const EdgeInsets.only(top: 12.0, bottom: 12.0),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      validator: (String val) {
                        if (val.isEmpty) {
                          return "field can't be empty";
                        }
                      },
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        hintStyle: TextStyle(
                          fontFamily: 'Signika Negative',
                          color: Colors.grey[500],
                        ),
                        contentPadding:
                            const EdgeInsets.only(top: 12.0, bottom: 12.0),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      validator: (String val) {
                        if (val.isEmpty) {
                          return "field can't be empty";
                        } else if (val.length < 6) {
                          return "password should have at least six characters";
                        }
                      },
                      controller: _passwordController,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: TextStyle(
                          fontFamily: 'Signika Negative',
                          color: Colors.grey[500],
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.remove_red_eye),
                          onPressed: _viewPassword,
                        ),
                        contentPadding:
                            const EdgeInsets.only(top: 12.0, bottom: 12.0),
                      ),
                      obscureText: _obscureText,
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      validator: (String val) {
                        if (val.isEmpty) {
                          return "field can't be empty";
                        } else if (val != _passwordController.text) {
                          return "should be same as password";
                        }
                      },
                      controller: _confirmPasswordController,
                      decoration: InputDecoration(
                        hintText: 'Confirm password',
                        hintStyle: TextStyle(
                          fontFamily: 'Signika Negative',
                          color: Colors.grey[500],
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.remove_red_eye),
                          onPressed: _viewConfirmPassword,
                        ),
                        contentPadding:
                            const EdgeInsets.only(top: 12.0, bottom: 12.0),
                      ),
                      obscureText: _obscureConfirmText,
                    ),
                    SizedBox(height: 40.0),
                    InkWell(
                      onTap: () async {
                        if (registerFormKey.currentState.validate()) {
                          //Call For Register
                          Map<String, String> data = {
                            "username": _usernameController.text,
                            "email": _emailController.text,
                            "password": _passwordController.text
                          };
                          print(data);
                          var responseRegister =
                              await networkHandler.post("/register", data);
                          print(responseRegister.body);
                          Map<String, String> loginData = {
                            "email": _emailController.text,
                            "password": _passwordController.text
                          };
                          var responseLogin =
                              await networkHandler.post("/login", loginData);
                          Map<String, dynamic> loginOutput =
                              json.decode(responseLogin.body);
                          print(loginOutput);
                          await storage.write(
                              key: "id", value: loginOutput["_id"]);
                          await storage.write(
                              key: "email", value: _emailController.text);
                          await storage.write(
                              key: "password", value: _passwordController.text);
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: Home(),
                            ),
                          );
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(15.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: textColor,
                        ),
                        child: Text(
                          'Sign up',
                          style: TextStyle(
                            fontFamily: 'Signika Negative',
                            fontSize: 18.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: nestedAppBar(),
    );
  }
}
