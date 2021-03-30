import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:project/ui/animation/login_animation.dart';
import 'package:project/ui/utils/color_utils.dart';
import 'package:project/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();
  String password = "";
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final authProvider = Provider.of<AuthService>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: FadeAnimation(1, Text("Reset password")),
      ),
      body: Form(
        key: _formKey,
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  SizedBox(
                    height: height / 4,
                  ),
                  FadeAnimation(
                    1,
                    Theme(
                      data: new ThemeData(
                        primaryColor: primaryColor,
                        primaryColorDark: primaryColor,
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        validator: (val) {
                          if (!EmailValidator.validate(val)) {
                            return "invalid email";
                          }
                          password = val;
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: "email",
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 20),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ))),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FadeAnimation(
                      2,
                      InkWell(
                        onTap: authProvider.isLoading
                            ? null
                            : () async {
                                if (_formKey.currentState.validate()) {
                                  authProvider.resetPassword(password,context);
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
                                    "Reset",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
