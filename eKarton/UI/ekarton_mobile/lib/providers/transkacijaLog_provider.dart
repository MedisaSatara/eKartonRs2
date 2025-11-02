import 'dart:convert';

import 'package:ekarton_mobile/models/bolnica.dart';
import 'package:ekarton_mobile/models/kategorijatranskacije.dart';
import 'package:ekarton_mobile/models/search_result.dart';
import 'package:ekarton_mobile/models/transakcija25062025.dart';
import 'package:ekarton_mobile/models/transkacijeLog25062025.dart';
import 'package:ekarton_mobile/providers/base_provider.dart';
import 'package:ekarton_mobile/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class TranskacijalogProvider extends BaseProvider<Transkacijelog25062025> {
  TranskacijalogProvider() : super("TransakcijaLog");

  @override
  Transkacijelog25062025 fromJson(data) {
    return Transkacijelog25062025.fromJson(data);
  }
}
