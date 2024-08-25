import 'dart:convert';

import 'package:ekarton_mobile/models/bolnica.dart';
import 'package:ekarton_mobile/models/doktor.dart';
import 'package:ekarton_mobile/models/search_result.dart';
import 'package:ekarton_mobile/providers/base_provider.dart';
import 'package:ekarton_mobile/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class DoktorProvider extends BaseProvider<Doktor> {
  DoktorProvider() : super("Doktor");

  @override
  Doktor fromJson(data) {
    return Doktor.fromJson(data);
  }
}
