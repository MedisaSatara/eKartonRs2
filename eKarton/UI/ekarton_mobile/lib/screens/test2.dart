import 'package:flutter/material.dart';

class PaymentDetailsScreen extends StatelessWidget {
  final String paymentIntentId;

  const PaymentDetailsScreen({Key? key, required this.paymentIntentId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Details"),
      ),
      body: Center(
        child: Text("Payment Intent ID: $paymentIntentId"),
      ),
    );
  }
}
