import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/ui/utils/color_utils.dart';

class ComplaintScreen extends StatefulWidget {
  @override
  _ComplaintScreenState createState() => _ComplaintScreenState();
}

// showCupertinoModalPopup(
//   context: context,
//   builder: (BuildContext context) => CupertinoActionSheet(
//       title: const Text('Choose Options'),
//       message: const Text('Your options are '),
//       actions: <Widget>[
//         CupertinoActionSheetAction(
//           child: const Text('One'),
//           onPressed: () {
//             Navigator.pop(context, 'One');
//           },
//         ),
//         CupertinoActionSheetAction(
//           child: const Text('Two'),
//           onPressed: () {
//             Navigator.pop(context, 'Two');
//           },
//         )
//       ],
//       ),
// );
class _ComplaintScreenState extends State<ComplaintScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _hostelController = TextEditingController();
  List<String> _hostels = [
    "Danfodio hall",
    "Ribadu hall",
    "Alexander hall",
    "Ribadu",
    "Suleiman hall",
    "Amina hall",
    "Shehu idris",
    "Aliko dangote",
    "ICSA/Ramat"
  ];
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
                  child: GestureDetector(
                    onTap: () {
                      showCupertinoModalPopup(
                          context: context,
                          builder: (BuildContext context) =>
                              CupertinoActionSheet(
                                title: const Text('Choose your hostel'),
                                // message: const Text('Your options are '),
                                actions: _hostels
                                    .map((e) => CupertinoActionSheetAction(
                                          child: Text(e),
                                          onPressed: () {
                                            _hostelController.text = e;
                                            Navigator.pop(context, 'One');
                                          },
                                        ))
                                    .toList(),
                                // <Widget>[
                                //   CupertinoActionSheetAction(
                                //     child: const Text('One'),
                                //     onPressed: () {
                                //       Navigator.pop(context, 'One');
                                //     },
                                //   ),
                                //   CupertinoActionSheetAction(
                                //     child: const Text('Two'),
                                //     onPressed: () {
                                //       Navigator.pop(context, 'Two');
                                //     },
                                //   )
                                // ],
                                cancelButton: CupertinoActionSheetAction(
                                  child: const Text(
                                    'Cancel',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  isDefaultAction: true,
                                  onPressed: () {
                                    Navigator.pop(context, 'Cancel');
                                  },
                                ),
                              ));
                    },
                    child: AbsorbPointer(
                      child: TextFormField(
                        // maxLength: 30,Î
                        controller: _hostelController,
                        validator: (val) {
                          String validatedInput =
                              val.replaceAll(" ", "").trim();
                          if (validatedInput.isEmpty) {
                            return "required";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: "hostel",
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
                ),
              ),
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
                    // controller: _aboutRoomController,
                    maxLines: 6,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFEAEDF6),
                      hintText: '',
                      border: InputBorder.none,
                    ),
                    validator: (val) {
                      String validatedInput = val.replaceAll(" ", "").trim();
                      if (validatedInput.length < 10) {
                        return "invalid too short";
                      }
                      return null;
                    },
                  ),
                  //  TextFormField(
                  //   // maxLength: null,

                  //   validator: (val) {
                  //     String validatedInput = val.replaceAll(" ", "").trim();
                  //     if (validatedInput.length < 10) {
                  //       return "invalid too short";
                  //     }
                  //     return null;
                  //   },
                  //   maxLines: null,
                  //   maxLength: 300,
                  //   decoration: InputDecoration(
                  //       labelText: "description",
                  //       contentPadding:
                  //           EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  //       border: OutlineInputBorder(
                  //           borderRadius:
                  //               BorderRadius.all(Radius.circular(10.0)),
                  //           borderSide: BorderSide(
                  //             color: Colors.transparent,
                  //           ))),
                  // ),
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
