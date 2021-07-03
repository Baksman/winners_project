// import 'dart:io';

// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/date_symbol_data_local.dart';
// import 'package:intl/intl.dart';
// import 'package:intl_phone_number_input/intl_phone_number_input.dart';
// import 'package:permission_handler/permission_handler.dart';

// import '../models/user_model.dart';
// import '../services/database_service.dart';
// import '../services/storage_service.dart';
// import '../utilities/country_iso_code.dart';
// import '../utilities/dialog_.utils.dart';
// import '../utilities/permission_handler.dart';
// import '../utilities/snackbar_utils.dart';
// import '../widgets/date_widget.dart';
// import 'profile_photo_view.dart';

import 'dart:io';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:awesome_loader/awesome_loader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:project/database/database_service.dart';
import 'package:project/database/storage_service.dart';
import 'package:project/faculties.dart';
import 'package:project/hostels.dart';
import 'package:project/model/user_model.dart';
import 'package:project/permisssion_utils.dart';
import 'package:project/ui/photo_view_screen.dart';
import 'package:project/ui/utils/color_utils.dart';
import 'package:project/ui/utils/flush_bar_utils.dart';
import 'package:project/ui/utils/log_utils.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  static final String routeName = "edit_profile_screen";
  final AppUser user;

  const EditProfileScreen(this.user);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

//ProgressDialog prd;
class _EditProfileScreenState extends State<EditProfileScreen> {
  final genders = [
    "Male",
    "Female",
  ];
  String matricNo;
  String faculty;
  String dept;
  String hostel;
  String name;
  String mobileNumber;
  bool isLocationTapped = false;
  final nameRegex = new RegExp(r"[a-zA-Z \s]");
  final _formKey = GlobalKey<FormState>();
  // TextEditingController hostel = TextEditingController();

  TextEditingController _genderController;
  TextEditingController _facultyController = TextEditingController();
  // TextEditingController _dateController;
  bool isLoading = false;

  //bool isFreelance;
  // File pdf;
  final picker = ImagePicker();

  File profileImage;
  String gender;
  // String _countryIso;

  void _hangleImage() async {
    PickedFile file = await picker.getImage(source: ImageSource.gallery);
    if (file != null) {
      setState(() {
        profileImage = File(file.path);
      });
    }
  }

  // to determine what type of image to  when image is tapped
  ImageProvider _getImage() {
    if (profileImage == null) {
      if (_user.imageUrl.isEmpty ?? false) {
        return AssetImage("assets/images/profile_pic.png");
      }
      return CachedNetworkImageProvider(_user.imageUrl);
    } else {
      return FileImage(profileImage);
    }
  }

  // on phone number field changed
  AppUser _user;
  TextEditingController countryController;
  TextEditingController _hostelController;
  // TextEditingController _genderController = TextEditingController();
  String uuid;
  @override
  void initState() {
    // initializeDateFormatting('en_US,', null);
    uuid = Provider.of<AppUser>(context, listen: false).uuid;
    gender = widget.user.gender;
    _hostelController = TextEditingController();
    // _dateController = TextEditingController(
    //     text: _birthday == null
    //         ? ""
    //         : "${DateFormat.yMMMMd("en_us").format(_birthday.toDate())}");

    _genderController = TextEditingController(text: widget.user.gender ?? "");

    // _phoneNumberController = (widget.user.mobileNumber.isNotEmpty) &&
    //         (widget.user.phoneNumber.length > 5)
    //     ? TextEditingController(text: widget.user.phoneNumber.substring(4))
    //     : TextEditingController(text: "");

    super.initState();
  }

  //GlobalKey _scrollKey = GlobalKey();

  @override
  void dispose() {
    // _locationController?.dispose();

    _genderController.dispose();
    // _phoneNumberController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    final width = MediaQuery.of(context).size.width;

    return Theme(
      data: new ThemeData(
        primaryColor: primaryColor,
        primaryColorDark: primaryColor,
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: FutureBuilder<AppUser>(
            future: DatabaseService.getUserData(uuid),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                logger.d(snapshot.error);
              }
              if (!snapshot.hasData) {
                return Center(
                    child: AwesomeLoader(
                  color: primaryColor,
                  loaderType: AwesomeLoader.AwesomeLoader3,
                ));
              }
              _user = snapshot.data;
              _hostelController.text = _user.hostel;
              _genderController.text = _user.gender;
              _facultyController.text = _user.faculty;
              return Form(
                key: _formKey,
                child: SingleChildScrollView(
                  //key: _scrollKey,
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return PhotoViewScreen(
                                    image: profileImage,
                                    imageUrl: _user.imageUrl,
                                    // user: widget.user,
                                  );
                                }));
                              },
                              child: Hero(
                                transitionOnUserGestures: true,
                                tag: "img",
                                child: Container(
                                  height: width - 100,
                                  width: width - 100,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: _getImage(),
                                          fit: BoxFit.cover),
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                              ),
                            ),
                            Positioned(
                                top: width / 2,
                                right: width / 2 - 65,
                                child: Container(
                                  // width: 40,
                                  // height: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      //  color: Colors.black,
                                      gradient: LinearGradient(colors: [
                                        primaryColor,
                                        Colors.white
                                      ])),

                                  child: IconButton(
                                    color: Colors.white,
                                    icon: Icon(Icons.camera_enhance),
                                    onPressed: () {
                                      logger.d("pressed");
                                      PermissionHandler.checkIfPermitted(
                                          _hangleImage,
                                          context,
                                          Permission.photos);
                                    },
                                    iconSize: 30,
                                  ),
                                )),
                          ],
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          initialValue: _user.name,
                          maxLength: 50,
                          onFieldSubmitted: (String val) {
                            name = val;
                          },
                          validator: (String val) {
                            if (val.trim().length < 3) {
                              return "name too short";
                            } else if (!nameRegex.hasMatch(val)) {
                              return "invalid name";
                            }
                            name = val.trim();
                            return null;
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            hintText: "name",
                            icon: Icon(Icons.person),
                            counterText: "",
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          initialValue: _user.matricNumber,
                          // initialValue: widget.user.name ?? "",
                          //keyboardType: Ke,
                          maxLines: null,
                          validator: (input) {
                            String val = input.replaceAll(" ", "");
                            if (val.length < 9) {
                              return "invalid";
                            }
                            matricNo = val;
                            return null;
                          },
                          maxLength: 12,
                          decoration: InputDecoration(
                            icon: Icon(Icons.school),
                            hintText: "matric No",
                            counterText: "",
                            contentPadding: EdgeInsets.all(10),
                          ),
                        ),
                        SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            showCupertinoModalPopup(
                                context: context,
                                builder: (BuildContext context) =>
                                    CupertinoActionSheet(
                                      title: const Text('Choose your hostel'),
                                      // message: const Text('Your options are '),
                                      actions: FACULTIES
                                          .map(
                                              (e) => CupertinoActionSheetAction(
                                                    child: Text(
                                                      e,
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                    onPressed: () {
                                                      _facultyController.text =
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
                              // initialValue: widget.user.name ?? "",
                              //keyboardType: Ke,
                              // initialValue: _user.faculty,
                              controller: _facultyController,
                              validator: (input) {
                                if (input.isEmpty) {
                                  return "invalid";
                                }
                                faculty = input;
                                return null;
                              },
                              decoration: InputDecoration(
                                icon: Icon(Icons.stairs),
                                hintText: "Faculty",
                                contentPadding: EdgeInsets.all(10),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          initialValue: _user.department,
                          // initialValue: widget.user.name ?? "",
                          //keyboardType: Ke,
                          maxLength: 30,
                          validator: (input) {
                            if (input.isEmpty) {
                              return "invalid";
                            }
                            dept = input;

                            return null;
                          },
                          decoration: InputDecoration(
                            icon: Icon(Icons.class_),
                            counterText: "",
                            hintText: "Department",
                            contentPadding: EdgeInsets.all(10),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          enabled: false,
                          initialValue: _user.email,
                          //keyboardType: Ke,
                          // maxLines: null,

                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            icon: Icon(Icons.email),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            _openGenderSheet(isDark);
                          },
                          child: AbsorbPointer(
                            child: TextFormField(
                              // initialValue: _user.gender,
                              controller: _genderController,

                              decoration: InputDecoration(
                                  hintText: "gender",
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 10),
                                  icon: Icon(Icons.person_pin)),
                            ),
                          ),
                        ),

                        SizedBox(height: 10),
                        // GestureDetector(
                        //     onTap: () {
                        //       DatePicker.showDatePicker(
                        //         context,
                        //         pickerTheme: DateTimePickerTheme.Default,
                        //         onConfirm: (date, _) {
                        //           var fmtdate = DateFormat.yMMMMd("en_us").format(date);
                        //           _dateController.text = "$fmtdate";
                        //           _birthday = Timestamp.fromDate(date);
                        //         },
                        //         minDateTime: DateTime(
                        //           1920,
                        //           1,
                        //           1,
                        //           0,
                        //         ),
                        //         maxDateTime: DateTime(2020, 1, 1, 0),
                        //       );
                        //     },
                        //     child: AbsorbPointer(
                        //         child: TextFormField(
                        //       controller: _dateController,
                        //       decoration: InputDecoration(
                        //         contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        //         hintText: "Birthday",
                        //         icon: Icon(Icons.date_range),
                        //       ),
                        //     ))),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
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
                                                    child: Text(
                                                      e,
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    ),
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
                                icon: Icon(Icons.house_outlined),
                                contentPadding: EdgeInsets.all(10),
                              ),
                            ),
                          ),
                        ),
                        // TextFormField(
                        //   initialValue: _user.hostel,
                        //   keyboardType: TextInputType.name,
                        //   maxLines: null,
                        //   maxLength: 100,
                        //   validator: (input) {
                        //     if (input.isEmpty) {
                        //       return "invalid";
                        //     }
                        //     hostel = input;
                        //     return null;
                        //   },
                        //   decoration: InputDecoration(
                        //     hintText: "hostel",
                        //     counterText: "",
                        //     contentPadding: EdgeInsets.all(10),
                        //     icon: Icon(Icons.house_outlined),
                        //   ),
                        //   onSaved: (String newLocation) {
                        //     // location = newLocation;
                        //   },
                        // ),
                        SizedBox(height: 20),
                        IntlPhoneField(
                          initialValue: _user.mobileNumber ?? "",

                          // controller: phoneNumberController,
                          decoration: InputDecoration(
                            labelText: 'Phone Number',
                          ),
                          initialCountryCode: 'NG',

                          onSubmitted: (_) {
                            // countryISO = phone.countryISOCode;
                          },
                          onSaved: (phone) {
                            mobileNumber = phone.number;
                          },
                        ),
                        // InternationalPhoneNumberInput(
                        //     ignoreBlank: true,
                        //     initialCountry2LetterCode: widget.user.countryIso ?? "NG",
                        //     textFieldController: _phoneNumberController,
                        //     autoValidate: true,
                        //     countries: countryIso,
                        //     onInputChanged: _onInputChanged),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: 120,
                          height: 45,
                          child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              color: primaryColor,
                              // disabledColor: Colors.teal,
                              child: !isLoading
                                  ? AnimatedSwitcher(
                                      duration: Duration(milliseconds: 160),
                                      child: Text(
                                        "Submit",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700),
                                      ))
                                  : CircularProgressIndicator(
                                      valueColor:
                                          AlwaysStoppedAnimation(primaryColor),
                                    ),
                              onPressed: !isLoading ? _submit : null),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }

  _openGenderSheet(bool isDark) {
    showCupertinoModalPopup(
        context: context,
        builder: (ctx) {
          return action(isDark);
        });
  }

  CupertinoActionSheet action(bool isDark) {
    return CupertinoActionSheet(
      title: Text(
        "Gender",
        style: TextStyle(fontSize: 30),
      ),
      message: Text("Choose your gender"),
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: Text(
            "Female",
            style: TextStyle(color: isDark ? Colors.white : Colors.black),
          ),
          isDestructiveAction: true,
          onPressed: () {
            _genderController.text = "Female";
            gender = "Female";

            Navigator.pop(context);
          },
        ),
        CupertinoActionSheetAction(
          child: Text(
            "Male",
            style: TextStyle(color: isDark ? Colors.white : Colors.black),
          ),
          isDestructiveAction: true,
          onPressed: () {
            _genderController.text = "Male";
            gender = "Male";
            Navigator.pop(context);
          },
        )
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text("Cancel"),
        isDestructiveAction: true,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

// List<String> docPath;
//    void _getDocuments() async {
//     docPath = await DocumentsPicker.pickDocuments;

//     if (!mounted) return;
//     setState(() {});
//   }

//35151
  void _submit() async {
    if (_formKey.currentState.validate() && !isLoading) {
      try {
        _formKey.currentState.save();

        setState(() {
          isLoading = true;
        });
        String profileImageUrl = "";

        if (profileImage == null) {
          profileImageUrl = _user.imageUrl;
        } else {
          profileImageUrl = await StorageService.uploadUserPicture(
              widget.user.imageUrl ?? "", profileImage);
        }

        //determine if theres is

        // String number =
        //     phoneNumber.length <= 4 ? widget.user.phoneNumber : phoneNumber;
        // if (name.trim().isNotEmpty && pdfUrl.isNotEmpty) {
        //   _canApply = true;
        // } else {
        //   _canApply = false;
        // }

        AppUser user = _user.copyWith(
            uuid: uuid,
            department: dept,
            name: name,
            faculty: faculty,
            matricNumber: matricNo,
            imageUrl: profileImageUrl,
            mobileNumber: mobileNumber,
            // dateRegistered: _user.dateRegistered,
            hostel: hostel,
            gender: gender);

        //decide if there is any update to userprofile;
        // if (widget.user == user && pdf == null && profileImage == null) {
        //   user.lastUpdated = widget.user.lastUpdated;
        // } else {
        //   user.lastUpdated = Timestamp.now();
        // }ibr

        await DatabaseService.addUser(user);

        setState(() {
          isLoading = false;
        });

        Navigator.pop(context);
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        if (e is PlatformException) {
          if (e.toString().contains("ERROR_NETWORK_REQUEST_FAILED")) {
            showFlushBarWidget("Error occured check your internet connection")
                .show(context);
            // SnackBarUtils.showSnackBar(
            //     _scaffoldKey, "Error occured, check your internet connection");
            return;
          }
          showFlushBarWidget("Error occured please try again").show(context);
        }
        logger.d(e);
        // SnackBarUtils.showSnackBar(
        //     _scaffoldKey, "Unknow error occured,try submitting again");
        //show general error dialog
      }
    }
  }
}
