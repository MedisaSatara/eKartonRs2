import 'dart:convert';

import 'package:ekarton_admin/models/bolnica.dart';
import 'package:ekarton_admin/models/search_result.dart';
import 'package:ekarton_admin/models/uloga.dart';
import 'package:ekarton_admin/providers/base_provider.dart';
import 'package:ekarton_admin/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class UlogaProvider extends BaseProvider<Uloga> {
  UlogaProvider() : super("Uloga");

  @override
  Uloga fromJson(data) {
    return Uloga.fromJson(data);
  }
}
