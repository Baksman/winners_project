import 'package:flutter/material.dart';
import 'package:project/ui/utils/color_utils.dart';

class ComplaintScreen extends StatefulWidget {
  @override
  _ComplaintScreenState createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Theme(
                  data: new ThemeData(
                    primaryColor: primaryColor,
                    primaryColorDark: primaryColor,
                  ),
                  child: TextFormField(
                    maxLength: 30,
                    validator: (val) {
                      String validatedInput = val.replaceAll(" ", "").trim();
                      if (validatedInput.length < 5) {
                        return "invalid too short";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: "title",
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
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
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Theme(
                  data: new ThemeData(
                    primaryColor: primaryColor,
                    primaryColorDark: primaryColor,
                  ),
                  child: TextFormField(
                    // maxLength: null,

                    validator: (val) {
                      String validatedInput = val.replaceAll(" ", "").trim();
                      if (validatedInput.length < 10) {
                        return "invalid too short";
                      }
                      return null;
                    },
                    maxLines: null,
                    maxLength: 300,
                    decoration: InputDecoration(
                        labelText: "description",
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(children: [
                  Expanded(
                    child: RaisedButton(
                      color: primaryColor,
                      onPressed: () {
                        if (_formKey.currentState.validate()) {}
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        "Submit",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
