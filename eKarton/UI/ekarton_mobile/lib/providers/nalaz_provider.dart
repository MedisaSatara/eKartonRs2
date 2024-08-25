import 'dart:convert';

import 'package:ekarton_mobile/models/nalaz.dart';
import 'package:ekarton_mobile/models/search_result.dart';
import 'package:ekarton_mobile/providers/base_provider.dart';
import 'package:ekarton_mobile/models/pacijent.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class NalazProvider extends BaseProvider<Nalaz> {
  NalazProvider() : super("Nalaz");

  @override
  Nalaz fromJson(data) {
    return Nalaz.fromJson(data);
  }
}
