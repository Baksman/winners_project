import 'package:awesome_loader/awesome_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/database/database_service.dart';
import 'package:project/model/complaint_model.dart';
import 'package:project/model/user_model.dart';
import 'package:project/ui/utils/color_utils.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../hostels.dart';

class ComplaintScreen extends StatefulWidget {
  @override
  _ComplaintScreenState createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _hostelController = TextEditingController();
  String hostel;
  String title;
  String description;
  @override
  Widget build(BuildContext context) {
    final dbProvider = Provider.of<DatabaseService>(context);
    final uuid = Provider.of<AppUser>(context).uuid;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
      ),
      body: FutureBuilder<AppUser>(
          future: DatabaseService.getUserData(uuid),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: AwesomeLoader(
                  color: primaryColor,
                  loaderType: AwesomeLoader.AwesomeLoader3,
                ),
              );
            }
            AppUser user = snapshot.data;
            _hostelController.text = user.hostel;
            return SingleChildScrollView(
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
                                      actions: hostels
                                          .map(
                                              (e) => CupertinoActionSheetAction(
                                                    child: Text(e),
                                                    onPressed: () {
                                                      _hostelController.text =
                                                          e;
                                                      Navigator.pop(context);
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
                                hostel = val;
                                return null;
                              },
                              decoration: InputDecoration(
                                  labelText: "hostel",
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 20),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
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
                            String validatedInput =
                                val.replaceAll(" ", "").trim();
                            if (validatedInput.length < 5) {
                              return "invalid too short";
                            }
                            title = validatedInput;
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: "title",
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
                            hintText: 'description',
                            border: InputBorder.none,
                          ),
                          validator: (val) {
                            String validatedInput =
                                val.replaceAll(" ", "").trim();
                            if (validatedInput.length < 10) {
                              return "invalid too short";
                            }
                            description = validatedInput;
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
                            padding: EdgeInsets.symmetric(vertical: 12),
                            color: primaryColor,
                            onPressed: dbProvider.isLoading
                                ? null
                                : () async {
                                    if (_formKey.currentState.validate()) {
                                      String complaintID = Uuid().v4();
                                      Complaint complaint = Complaint(
                                          title: title,
                                          hostel: hostel,
                                          userId: uuid,
                                          complaintID: complaintID,
                                          // timeStamp: null,
                                          desc: description);
                                      bool res = await dbProvider.addCompliant(
                                          complaint, context);
                                      if (res ?? false) {
                                        Navigator.pop(context);
                                      }
                                    }
                                  },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: dbProvider.isLoading
                                ? CircularProgressIndicator()
                                : Text(
                                    "Submit",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                          ),
                        ),
                      ]),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
