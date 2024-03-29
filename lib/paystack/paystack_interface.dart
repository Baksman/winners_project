// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:project/paystack/api_key.dart';
// import 'package:project/ui/utils/log_utils.dart';

// class PayStackInterface extends ChangeNotifier {
//   final int amount;
//   // cvv 3digit
//   final String cvv;
//   // 2 digit
//   final int expiryMonth;
//   // 2 digit
//   final int expiryYear;

//   final String cardNumber;

//   final String email;
//   final String userID;
//   String responseMessage;
//   bool _isLoading = false;

//   bool get isLoading => _isLoading;

//   PayStackInterface(
//       {Key key,
//       @required this.amount,
//       @required this.cvv,
//       @required this.userID,
//       @required this.email,
//       @required this.expiryMonth,
//       @required this.expiryYear,
//       @required this.cardNumber});

//   // void initalisePayStack() {

//   // }
//   Future<bool> processPayment(BuildContext context) async {
//     Charge charge = Charge()
//       ..amount = amount * 100// In base currency
//       ..email = email
//       ..accessCode = userID
//       ..card = _getCardFromUI();
//     _isLoading = true;
//     // notifyListeners();
//     try {
//       CheckoutResponse response = await PaystackPlugin.checkout(
//         context,
//         // for card only;

//         method: CheckoutMethod.card,
//         charge: charge,
//         fullscreen: false,
//       );
//       _isLoading = false;
//       // notifyListeners();
//       logger.d(response.message);
//       logger.d(response.status);
//       responseMessage = response.message;
//       // Navigator.pop(context);

//       return response.status;
//     } catch (e) {
//       // Navigator.pop(context);
//       _isLoading = false;
//       logger.d(e);

//       // notifyListeners();
//       return false;
//     }
//   }

//   PaymentCard _getCardFromUI() {
//     // Using just the must-required parameters.
//     return PaymentCard(
//       number: cardNumber,
//       cvc: cvv,
//       expiryMonth: expiryMonth,
//       expiryYear: expiryYear,
//     );
//   }

//   startAfreshCharge() async {
//     Charge charge = Charge();
//     charge.card = _getCardFromUI();

//     bool _isLocal = false;

//     if (_isLocal) {
//       charge
//         ..amount = 10000 // In base currency
//         ..email = email
//         ..reference = _getReference()
//         ..putCustomField('Charged From', 'Flutter SDK');
//       _chargeCard(charge);
//     } else {
//       charge.accessCode = await Future.value();
//       _chargeCard(charge);
//     }
//   }

//   _chargeCard(Charge charge) async {
//     final response = await Future.value();

//     final reference = response.reference;
//   }

//   String _getReference() {
//     String platform;
//     if (Platform.isIOS) {
//       platform = 'iOS';
//     } else {
//       platform = 'Android';
//     }

//     return 'ChargedFrom${platform}_${DateTime.now().millisecondsSinceEpoch}';
//   }
// }
