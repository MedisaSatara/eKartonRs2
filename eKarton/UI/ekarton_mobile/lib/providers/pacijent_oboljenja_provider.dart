import 'dart:convert';

import 'package:ekarton_mobile/models/pacijent.dart';
import 'package:ekarton_mobile/models/pacijent_oboljenja.dart';
import 'package:ekarton_mobile/models/search_result.dart';
import 'package:ekarton_mobile/providers/base_provider.dart';
import 'package:ekarton_mobile/models/pacijent.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class PacijentOboljenjaProvider extends BaseProvider<PacijentOboljenja> {
  PacijentOboljenjaProvider() : super("PacijentOboljenje");

  @override
  PacijentOboljenja fromJson(data) {
    return PacijentOboljenja.fromJson(data);
  }
}
