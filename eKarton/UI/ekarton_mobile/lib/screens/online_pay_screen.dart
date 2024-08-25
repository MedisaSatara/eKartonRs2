import 'dart:convert';
import 'package:ekarton_mobile/providers/stripe_service.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class OnlinePayScreen extends StatefulWidget {
  const OnlinePayScreen({Key? key}) : super(key: key);

  @override
  State<OnlinePayScreen> createState() => _OnlinePayScreen();
}

class _OnlinePayScreen extends State<OnlinePayScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Placanje'),
      ),
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MaterialButton(
              onPressed: () {
                StripeService.instance.makePayment();
              },
              color: Colors.green,
              child: const Text("Purchase"),
            )
          ],
        ),
      ),
    );
  }
}
