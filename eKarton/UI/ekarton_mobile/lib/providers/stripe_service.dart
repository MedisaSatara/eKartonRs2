import 'package:dio/dio.dart';
import 'package:ekarton_mobile/consts.dart';
import 'package:ekarton_mobile/screens/test2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class StripeService {
  StripeService._();

  static final StripeService instance = StripeService._();

  Future<String?> makePayment(BuildContext context, double amount,
      GlobalKey<FormBuilderState> formKey) async {
    try {
      var paymentData = await _createPaymentIntent(amount, "usd");
      if (paymentData == null || paymentData['client_secret'] == null) {
        _showErrorDialog(context, "Payment creation failed. Please try again.");
        return null;
      }

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentData['client_secret']!,
          merchantDisplayName: "Medisa Satara",
        ),
      );

      await _processPayment(context);
      return paymentData['payment_intent_id'];
    } catch (e) {
      print("Error in makePayment: $e");
      _showErrorDialog(
          context, "An unexpected error occurred. Please try again.");
      return null;
    }
  }

  Future<Map<String, String?>?> _createPaymentIntent(
      double amount, String currency) async {
    try {
      final Dio dio = Dio();
      Map<String, dynamic> data = {
        "amount": _calculateAmount(amount),
        "currency": currency,
      };

      var response = await dio.post(
        "https://api.stripe.com/v1/payment_intents",
        data: data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            "Authorization": "Bearer $stripeSecretKey",
            "Content-Type": "application/x-www-form-urlencoded",
          },
        ),
      );

      if (response.data != null &&
          response.data["client_secret"] != null &&
          response.data["id"] != null) {
        return {
          'client_secret': response.data["client_secret"],
          'payment_intent_id': response.data["id"],
        };
      } else {
        print("Failed to retrieve client secret or payment intent id");
        return null;
      }
    } catch (e) {
      print("Error in _createPaymentIntent: $e");
      return null;
    }
  }

  String _calculateAmount(double amount) {
    final calculatedAmount = (amount * 100).toInt();
    return calculatedAmount.toString();
  }

  Future<void> _processPayment(BuildContext context) async {
    try {
      await Stripe.instance.presentPaymentSheet();
      await Stripe.instance.confirmPaymentSheetPayment();
      showSuccessDialog(context);
    } catch (e) {
      print("Payment processing error: $e");
      _showErrorDialog(context, "Payment processing failed. Please try again.");
    }
  }

  void showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Uspješna transakcija"),
          content: Text("Plaćanje je uspješno!"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Greška"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _confirmAppointment() {}
}
