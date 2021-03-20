import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:project/ui/animation/login_animation.dart';
// import 'package:awesome_loader/awesome_loader.dart';
import 'package:project/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String email;
  String password;
  String password2;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthService>(context);
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
                                    "Sign up",
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
                                      validator: (val) {
                                        bool isValid =
                                            EmailValidator.validate(val);
                                        if (isValid) {
                                          email = val.trim();
                                          return null;
                                        }
                                        return "invalid email";
                                      },
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Email or Phone number",
                                          hintStyle: TextStyle(
                                              color: Colors.grey[400])),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      validator: (val) {
                                        String serialisedPass =
                                            val.trim().replaceAll(" ", "");
                                        if (serialisedPass.length < 5) {
                                          return "too short";
                                        }
                                        password = val;
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Password",
                                          hintStyle: TextStyle(
                                              color: Colors.grey[400])),
                                    ),
                                  ),
                                  Divider(),
                                  Container(
                                    padding: EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      validator: (val) {
                                        String serialisedPass =
                                            val.trim().replaceAll(" ", "");
                                        if (password != serialisedPass) {
                                          return "password does not match";
                                        }
                                        password = val;
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Comfirm password",
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
                              onTap: () async {
                                if (_formKey.currentState.validate()) {
                                  await authProvider.register(
                                      email: email,
                                      password: password,
                                      context: context);
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
                                          "Sign up",
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
                        FadeAnimation(
                            1.5,
                            FlatButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    color: Color.fromRGBO(143, 148, 251, 1)),
                              ),
                            )),
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
