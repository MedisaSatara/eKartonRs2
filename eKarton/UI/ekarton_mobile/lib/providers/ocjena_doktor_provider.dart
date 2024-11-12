import 'dart:convert';

import 'package:ekarton_mobile/models/ocjene_doktor.dart';
import 'package:ekarton_mobile/providers/base_provider.dart';
import 'package:ekarton_mobile/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class OcjenaDoktorProvider extends BaseProvider<OcjeneDoktor> {
  OcjenaDoktorProvider() : super("OcjenaDoktor");

  @override
  OcjeneDoktor fromJson(data) {
    return OcjeneDoktor.fromJson(data);
  }
}
