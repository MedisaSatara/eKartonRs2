import 'dart:convert';

import 'package:ekarton_admin/models/bolnica.dart';
import 'package:ekarton_admin/models/search_result.dart';
import 'package:ekarton_admin/providers/base_provider.dart';
import 'package:ekarton_admin/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class BolnicaProvider extends BaseProvider<Bolnica> {
  BolnicaProvider() : super("Bolnica");

  @override
  Bolnica fromJson(data) {
    return Bolnica.fromJson(data);
  }
}
