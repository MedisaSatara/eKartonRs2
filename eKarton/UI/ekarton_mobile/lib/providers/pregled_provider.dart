import 'dart:convert';

import 'package:ekarton_mobile/models/pregled.dart';
import 'package:ekarton_mobile/providers/base_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class PregledProvider extends BaseProvider<Pregled> {
  PregledProvider() : super("Pregled");

  @override
  Pregled fromJson(data) {
    return Pregled.fromJson(data);
  }
}
