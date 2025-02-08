import 'dart:convert';
import 'package:ekarton_mobile/consts.dart';
import 'package:ekarton_mobile/models/termin.dart';
import 'package:ekarton_mobile/providers/termin_provider.dart';
import 'package:ekarton_mobile/screens/termin_details_screen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class OnlinePaymentScreen extends StatefulWidget {
  final Termin reservation;
  const OnlinePaymentScreen({Key? key, required this.reservation}) : super(key: key);

  @override
  _OnlinePaymentScreenState createState() => _OnlinePaymentScreenState();
}

class _OnlinePaymentScreenState extends State<OnlinePaymentScreen> {
  Map<String, dynamic>? paymentIntent;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      await makePayment();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Placanje'),
      ),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Future<void> makePayment() async {
    try {
      double amount = widget.reservation!.cijenaPregleda!;
      String amountString = amount.toStringAsFixed(2);
      paymentIntent = await createPaymentIntent(amountString, 'bam');
      if (paymentIntent != null) {
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntent!['client_secret'],
            style: ThemeMode.dark,
            merchantDisplayName: 'Agencija',
          ),
        );
        await displayPaymentSheet();
      } else {
        print('Payment intent is null');
      }
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  Future<void> displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) async {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: const [
                    Icon(Icons.check_circle, color: Colors.green),
                    Text("Payment Successful"),
                  ],
                ),
              ],
            ),
          ),
        );
        savePaymentData();
        paymentIntent = null;

        await Future.delayed(const Duration(seconds: 4));

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => TerminDetailsScreen()),
        );
      }).onError((error, stackTrace) {
        print('Error is:--->$error $stackTrace');
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
      showDialog(
        context: context,
        builder: (_) => const AlertDialog(
          content: Text("Cancelled "),
        ),
      );
    } catch (e) {
      print('$e');
    }
  }

  Future<void> savePaymentData() async {
    try {
      // Save the payment data and transaction ID
      TerminProvider terminProvider = TerminProvider();

      // Update the Termin with the payment intent ID (transaction ID)
      Termin updatedTermin = await terminProvider.updateTransaction(
        widget.reservation.terminId!, // Assume you have the ID of the Termin
        paymentIntent!['id'], // Get the payment intent ID
      );

      print("Payment data updated with transaction ID: ${updatedTermin.brojTransakcije}");

    } catch (error) {
      print('Greška prilikom komunikacije s API-jem: $error');
    }
  }

  Future<Map<String, dynamic>> createPaymentIntent(String amount, String currency) async {
    try {
      int calculatedAmount = calculateAmount(amount);
      Map<String, String> body = {
        'amount': calculatedAmount.toString(),
        'currency': currency,
        'payment_method_types[]': 'card',
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $stripeSecretKey',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );

      print('Payment Intent Body->>> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
      rethrow;
    }
  }

  int calculateAmount(String amount) {
    final calculatedAmount = (double.parse(amount) * 100).toInt();
    return calculatedAmount;
  }
}