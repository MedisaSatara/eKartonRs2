import 'dart:convert';

import 'package:ekarton_mobile/models/termin.dart';
import 'package:ekarton_mobile/providers/base_provider.dart';
import 'package:ekarton_mobile/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class TerminProvider extends BaseProvider<Termin> {
  TerminProvider() : super("Termin");

  @override
  Termin fromJson(data) {
    return Termin.fromJson(data);
  }
  Future<Termin> updateTransaction(int id, String transactionId) async {
    final request = {
      'brojTransakcije': transactionId, // Update the transaction ID in the Termin
      // Add any other relevant fields to update
    };
    return await update(id, request);
  }
}
