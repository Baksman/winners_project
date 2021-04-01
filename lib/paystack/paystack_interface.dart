import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';

class PayStackInterface extends StatefulWidget {
  final int amount;
  // cvv 3digit
  final String cvv;
  // 2 digit
  final int expiryMonth;
  // 2 digi
  final int expiryYear;

  final String cardNumber;

  const PayStackInterface({Key key,@required this.amount,@required  this.cvv,@required  this.expiryMonth,@required  this.expiryYear,@required  this.cardNumber}) : super(key: key);

  @override
  _PayStackInterfaceState createState() => _PayStackInterfaceState();
}

class _PayStackInterfaceState extends State<PayStackInterface> {
  @override
  Widget build(BuildContext context) {
    return 
  }

    PaymentCard _getCardFromUI() {
    // Using just the must-required parameters.
    return PaymentCard(
      number: widget.cardNumber,
      cvc: widget.cvv,
      expiryMonth: widget.expiryMonth,
      expiryYear: widget.expiryYear,
    );

}}
