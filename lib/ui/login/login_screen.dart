// import 'package:awesome_loader/awesome_loader.dart';
// import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
// import 'package:kt_drawer_menu/kt_drawer_menu.dart';
import 'package:page_transition/page_transition.dart';
// import 'package:project/database/database_service.dart';
import 'package:project/ui/animation/login_animation.dart';
import 'package:project/ui/home_screen.dart';
import 'package:project/ui/sign/sign_up_screen.dart';
import 'package:project/ui/utils/color_utils.dart';
// import 'package:project/ui/widget/drawer.dart';
import 'package:project/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

import '../../email_validator.dart';
import '../../reset_password.dart';
// import 'package:project/ui/login/sign/animation/login_animation.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthService>(context);
    // final databaseProvider = Provider.of<DatabaseService>(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 400,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/background.png'),
                            fit: BoxFit.fill)),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          left: 30,
                          width: 80,
                          height: 200,
                          child: FadeAnimation(
                              1,
                              Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/light-1.png'))),
                              )),
                        ),
                        Positioned(
                          left: 140,
                          width: 80,
                          height: 150,
                          child: FadeAnimation(
                              1.3,
                              Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/light-2.png'))),
                              )),
                        ),
                        Positioned(
                          right: 40,
                          top: 40,
                          width: 80,
                          height: 150,
                          child: FadeAnimation(
                              1.5,
                              Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/clock.png'))),
                              )),
                        ),
                        Positioned(
                          child: FadeAnimation(
                              1.6,
                              Container(
                                margin: EdgeInsets.only(top: 50),
                                child: Center(
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Column(
                      children: <Widget>[
                        FadeAnimation(
                            1.8,
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color:
                                            Color.fromRGBO(143, 148, 251, .2),
                                        blurRadius: 20.0,
                                        offset: Offset(0, 10))
                                  ]),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey[100]))),
                                    child: TextFormField(
                                      keyboardType:TextInputType.emailAddress,
                                      validator: (val) {
                                        bool isValid = emailRegex.hasMatch(val);
                                        // EmailValidator.validate(val);
                                        if (isValid) {
                                          email = val.trim();
                                          return null;
                                        }

                                        return "invalid email";
                                      },
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Email address",
                                          hintStyle: TextStyle(
                                              color: Colors.grey[400])),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      obscureText: !showPassword,
                                      validator: (val) {
                                        String serialisedPass =
                                            val.trim().replaceAll(" ", "");
                                        if (serialisedPass.length < 5) {
                                          return "password is too short";
                                        }
                                        password = val.trim();
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                          suffixIcon: IconButton(
                                            color: primaryColor,
                                            icon: showPassword
                                                ? Icon(Icons.visibility)
                                                : Icon(Icons.visibility_off),
                                            onPressed: () {
                                              setState(() {
                                                showPassword = !showPassword;
                                              });
                                            },
                                          ),

                                          // icon: IconButton(icon: Icon(Icons.panorama_fish_eye), onPressed: null),
                                          border: InputBorder.none,
                                          hintText: "Password",
                                          hintStyle: TextStyle(
                                              color: Colors.grey[400])),
                                    ),
                                  )
                                ],
                              ),
                            )),
                        SizedBox(
                          height: 30,
                        ),
                        FadeAnimation(
                            2,
                            InkWell(
                              onTap: authProvider.isLoading
                                  ? null
                                  : () async {
                                      if (_formKey.currentState.validate()) {
                                        bool result = await authProvider.login(
                                            context: context,
                                            email: email,
                                            password: password);
                                        if (result ?? false) {
                                          Navigator.of(context)
                                              .pushAndRemoveUntil(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Home()),
                                                  (Route<dynamic> route) =>
                                                      false);
                                        }
                                      }
                                    },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: LinearGradient(colors: [
                                      Color.fromRGBO(143, 148, 251, 1),
                                      Color.fromRGBO(143, 148, 251, .6),
                                    ])),
                                child: Center(
                                  child: authProvider.isLoading
                                      ? CircularProgressIndicator()
                                      : Text(
                                          "Login",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                ),
                              ),
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            FadeAnimation(
                                1.5,
                                FlatButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          PageTransition(
                                              type: PageTransitionType
                                                  .rightToLeft,
                                              child: SignUpScreen()));
                                    },
                                    child: Text(
                                      "Sign up",
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(143, 148, 251, 1)),
                                    ))),
                            Spacer(),
                            FadeAnimation(
                                2.0,
                                FlatButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          PageTransition(
                                              type: PageTransitionType
                                                  .rightToLeft,
                                              child: ResetPassword()));
                                    },
                                    child: Text(
                                      "Reset",
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(143, 148, 251, 1)),
                                    ))),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
