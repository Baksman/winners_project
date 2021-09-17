// import 'dart:async';
// import 'dart:io';
// import 'package:project/paystack/api_key.dart';
// import 'package:project/ui/utils/color_utils.dart';
// import 'package:uuid/uuid.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_paystack/flutter_paystack.dart';
// import 'package:http/http.dart' as http;
// // import '../api_key.dart';

// String backendUrl = '{YOUR_BACKEND_URL}';

// const String appName = 'Paystack Example';

// class PaymentScreen extends StatefulWidget {
//   @override
//   _PaymentScreenState createState() => _PaymentScreenState();
// }

// class _PaymentScreenState extends State<PaymentScreen> {
//   final _scaffoldKey = new GlobalKey<ScaffoldState>();
//   Uuid uuid = Uuid();
//   final _formKey = GlobalKey<FormState>();
//   final _verticalSizeBox = const SizedBox(height: 20.0);
//   final _horizontalSizeBox = const SizedBox(width: 10.0);
//   // var _border = new Container(
//   //   width: double.infinity,
//   //   height: 1.0,
//   //   color: Colors.red,
//   // );
//   int amount;
//   int _radioValue = 0;
//   CheckoutMethod _method = CheckoutMethod.card;
//   bool _inProgress = false;
//   String _cardNumber;
//   String _cvv;
//   int _expiryMonth = 0;
//   int _expiryYear = 0;

//   @override
//   void initState() {
//     PaystackPlugin.initialize(publicKey: PAYSTACK_PUBLIC_KEY);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       key: _scaffoldKey,
//       appBar: new AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(
//             Icons.arrow_back_ios,
//             color: Colors.black,
//           ),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: new Container(
//         padding: const EdgeInsets.all(20.0),
//         child: new Form(
//           key: _formKey,
//           child: new SingleChildScrollView(
//             child: new ListBody(
//               children: <Widget>[
//                 _verticalSizeBox,
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 12.0),
//                   child: Text("Amount"),
//                 ),
//                 Container(
//                   margin: EdgeInsets.only(right: 10, left: 10),
//                   padding: EdgeInsets.all(2),
//                   decoration: BoxDecoration(
//                     color: Color.fromRGBO(234, 237, 247, 0.45),
//                     borderRadius: BorderRadius.circular(5),
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Center(
//                           child: Container(
//                         height: 30,
//                         width: 50,
//                         child: Center(
//                           child: Text(
//                             "NGN",
//                             style: TextStyle(color: Colors.white, fontSize: 10),
//                           ),
//                         ),
//                         decoration: BoxDecoration(
//                             color: Theme.of(context).primaryColor,
//                             borderRadius: BorderRadius.circular(10)),
//                       )),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Expanded(
//                         child: Padding(
//                           padding: const EdgeInsets.only(bottom: 0),
//                           child: new TextFormField(
//                             keyboardType: TextInputType.number,
//                             maxLength: 16,
//                             validator: (val) {
//                               int validatedVal = int.tryParse(val);
//                               if (validatedVal == null || validatedVal < 100) {
//                                 return "invalid amount";
//                               }
//                               amount = validatedVal;
//                               return null;
//                             },
//                             textAlignVertical: TextAlignVertical.center,
//                             decoration: InputDecoration(
//                                 counterText: "",
//                                 hintText: 'Amount',
//                                 //  errorText: "",
//                                 hintStyle: TextStyle(
//                                   fontSize: 14,
//                                   color: Color(0xff2C3D57).withOpacity(0.46),
//                                 ),
//                                 border: InputBorder.none,
//                                 focusedBorder: InputBorder.none,
//                                 enabledBorder: InputBorder.none,
//                                 errorBorder: InputBorder.none,
//                                 disabledBorder: InputBorder.none,
//                                 contentPadding: EdgeInsets.all(10)),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 _verticalSizeBox,

//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 10),
//                     child: Container(
//                       padding:
//                           EdgeInsets.symmetric(horizontal: 25, vertical: 10),
//                       height: 40,
//                       width: 120,
//                       child: Text(
//                         "Card",
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16),
//                       ),
//                       decoration: BoxDecoration(
//                           color: Theme.of(context).primaryColor,
//                           borderRadius: BorderRadius.circular(10)),
//                     ),
//                   ),
//                 ),
//                 // _verticalSizeBox,
//                 _verticalSizeBox,
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 12.0),
//                   child: Text("Card details"),
//                 ),
//                 Container(
//                   margin: EdgeInsets.only(right: 10, left: 10),
//                   padding: EdgeInsets.all(2),
//                   decoration: BoxDecoration(
//                     color: Color.fromRGBO(234, 237, 247, 0.45),
//                     borderRadius: BorderRadius.circular(5),
//                   ),
//                   child: TextFormField(
//                     onSaved: (String value) => _cardNumber = value,
//                     keyboardType: TextInputType.number,
//                     maxLength: 16,
//                     validator: (val) {
//                       int validated = int.tryParse(val.trim());
//                       if (validated == null || val.trim().length != 16) {
//                         return "invalid";
//                       }
//                       return null;
//                     },
//                     decoration: InputDecoration(
//                         hintText: 'Card details',
//                         counterText: "",
//                         hintStyle: TextStyle(
//                           fontSize: 14,
//                           color: Color(0xff2C3D57).withOpacity(0.46),
//                         ),
//                         border: InputBorder.none,
//                         focusedBorder: InputBorder.none,
//                         enabledBorder: InputBorder.none,
//                         errorBorder: InputBorder.none,
//                         disabledBorder: InputBorder.none,
//                         contentPadding: EdgeInsets.all(10)),
//                   ),
//                 ),
//                 _verticalSizeBox,
//                 new Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: <Widget>[
//                     new Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 12),
//                             child: Text("CVV"),
//                           ),
//                           Container(
//                             margin: EdgeInsets.only(right: 10, left: 10),
//                             padding: EdgeInsets.all(2),
//                             decoration: BoxDecoration(
//                               color: Color.fromRGBO(234, 237, 247, 0.45),
//                               borderRadius: BorderRadius.circular(5),
//                             ),
//                             child: new TextFormField(
//                               maxLength: 3,
//                               keyboardType: TextInputType.number,
//                               validator: (val) {
//                                 int validated = int.tryParse(val.trim());
//                                 if (validated == null ||
//                                     val.replaceAll(" ", "").length != 3) {
//                                   return "invalid";
//                                 }
//                                 _cvv = val.replaceAll(" ", "");
//                                 return null;
//                               },
//                               decoration: InputDecoration(
//                                   counterText: "",
//                                   hintText: 'CVV',

//                                   //  errorText: "",
//                                   hintStyle: TextStyle(
//                                     fontSize: 14,
//                                     color: Color(0xff2C3D57).withOpacity(0.46),
//                                   ),
//                                   border: InputBorder.none,
//                                   focusedBorder: InputBorder.none,
//                                   enabledBorder: InputBorder.none,
//                                   errorBorder: InputBorder.none,
//                                   disabledBorder: InputBorder.none,
//                                   contentPadding: EdgeInsets.all(10)),
//                               onSaved: (String value) => _cvv = value,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     // _horizontalSizeBox,
//                     new Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 12),
//                             child: Text("Exp/month"),
//                           ),
//                           Container(
//                             margin: EdgeInsets.only(right: 10, left: 10),
//                             padding: EdgeInsets.all(2),
//                             decoration: BoxDecoration(
//                               color: Color.fromRGBO(234, 237, 247, 0.45),
//                               borderRadius: BorderRadius.circular(5),
//                             ),
//                             child: new TextFormField(
//                               keyboardType: TextInputType.number,
//                               maxLength: 2,
//                               validator: (val) {
//                                 int validated = int.tryParse(val.trim());
//                                 if (validated == null ||
//                                     val.replaceAll(" ", "").length != 2) {
//                                   return "invalid";
//                                 }
//                                 _expiryMonth = validated;
//                                 return null;
//                               },
//                               decoration: InputDecoration(
//                                   counterText: "",
//                                   hintText: 'month',
//                                   //  errorText: "",
//                                   hintStyle: TextStyle(
//                                     fontSize: 14,
//                                     color: Color(0xff2C3D57).withOpacity(0.46),
//                                   ),
//                                   border: InputBorder.none,
//                                   focusedBorder: InputBorder.none,
//                                   enabledBorder: InputBorder.none,
//                                   errorBorder: InputBorder.none,
//                                   disabledBorder: InputBorder.none,
//                                   contentPadding: EdgeInsets.all(10)),
//                               onSaved: (String value) =>
//                                   _expiryMonth = int.tryParse(value),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     // _horizontalSizeBox,
//                     new Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 12),
//                             child: Text("Exp/Year"),
//                           ),
//                           Container(
//                             margin: EdgeInsets.only(right: 10, left: 10),
//                             padding: EdgeInsets.all(2),
//                             decoration: BoxDecoration(
//                               color: Color.fromRGBO(234, 237, 247, 0.45),
//                               borderRadius: BorderRadius.circular(5),
//                             ),
//                             child: new TextFormField(
//                               maxLength: 2,
//                               validator: (val) {
//                                 int validated = int.tryParse(val.trim());
//                                 if (validated == null ||
//                                     val.replaceAll(" ", "").length != 2) {
//                                   return "invalid";
//                                 }
//                                 _expiryMonth = validated;
//                                 return null;
//                               },
//                               keyboardType: TextInputType.number,
//                               decoration: InputDecoration(
//                                   counterText: "",
//                                   hintText: 'Year',
//                                   //  errorText: "",
//                                   hintStyle: TextStyle(
//                                     fontSize: 14,
//                                     color: Color(0xff2C3D57).withOpacity(0.46),
//                                   ),
//                                   border: InputBorder.none,
//                                   focusedBorder: InputBorder.none,
//                                   enabledBorder: InputBorder.none,
//                                   errorBorder: InputBorder.none,
//                                   disabledBorder: InputBorder.none,
//                                   contentPadding: EdgeInsets.all(10)),
//                               onSaved: (String value) =>
//                                   _expiryYear = int.tryParse(value),
//                             ),
//                           ),
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//                 _verticalSizeBox,
//                 Theme(
//                   data: Theme.of(context).copyWith(
//                     accentColor: green,
//                     primaryColorLight: Colors.white,
//                     primaryColorDark: navyBlue,
//                     textTheme: Theme.of(context).textTheme.copyWith(
//                           bodyText2: TextStyle(
//                             color: lightBlue,
//                           ),
//                         ),
//                   ),
//                   child: Builder(
//                     builder: (context) {
//                       return _inProgress
//                           ? new Container(
//                               alignment: Alignment.center,
//                               height: 50.0,
//                               child: Platform.isIOS
//                                   ? new CupertinoActivityIndicator()
//                                   : new CircularProgressIndicator(),
//                             )
//                           : new Column(
//                               mainAxisSize: MainAxisSize.min,
//                               children: <Widget>[
//                                 // _getPlatformButton(
//                                 //     'Charge Card', () => _startAfreshCharge()),
//                                 // _verticalSizeBox,
//                                 // // _border,
//                                 // new SizedBox(
//                                 //   height: 40.0,
//                                 // ),
//                                 new Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: <Widget>[
//                                     // new Flexible(
//                                     //   flex: 3,

//                                     // ),
//                                     _horizontalSizeBox,
//                                     new Flexible(
//                                       flex: 2,
//                                       child: new Container(
//                                         width: double.infinity,
//                                         child: _getPlatformButton(
//                                           'Comfirm payment',
//                                           () {},
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 )
//                               ],
//                             );
//                     },
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // void _handleRadioValueChanged(int value) =>
//   //     setState(() => _radioValue = value);

//   Widget _getPlatformButton(String string, Function() function) {
//     // is still in progress
//     Widget widget;
//     if (Platform.isIOS) {
//       widget = new CupertinoButton(
//         onPressed: function,
//         padding: const EdgeInsets.symmetric(horizontal: 15.0),
//         color: Theme.of(context).primaryColor,
//         child: new Text(
//           string,
//           maxLines: 1,
//           overflow: TextOverflow.ellipsis,
//         ),
//       );
//     } else {
//       widget = new RaisedButton(
//         onPressed: function,
//         color: Colors.blueAccent,
//         textColor: Colors.white,
//         padding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
//         child: new Text(
//           string.toUpperCase(),
//           style: const TextStyle(fontSize: 17.0),
//         ),
//       );
//     }
//     return widget;
//   }
// }

// var banks = ['Selectable', 'Bank', 'Card'];



// const Color green = const Color(0xFF3db76d);
// const Color lightBlue = const Color(0xFF34a5db);
// const Color navyBlue = const Color(0xFF031b33);
