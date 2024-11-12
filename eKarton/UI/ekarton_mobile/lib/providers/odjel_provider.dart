import 'dart:convert';

import 'package:ekarton_mobile/models/odjel.dart';
import 'package:ekarton_mobile/providers/base_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class OdjelProvider extends BaseProvider<Odjel> {
  OdjelProvider() : super("Odjel");

  @override
  Odjel fromJson(data) {
    return Odjel.fromJson(data);
  }
}
