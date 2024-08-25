import 'dart:convert';

import 'package:ekarton_admin/models/odjel.dart';
import 'package:ekarton_admin/models/osiguranje.dart';
import 'package:ekarton_admin/models/pacijent.dart';
import 'package:ekarton_admin/models/search_result.dart';
import 'package:ekarton_admin/providers/base_provider.dart';
import 'package:ekarton_admin/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class OsiguranjeProvider extends BaseProvider<Osiguranje> {
  OsiguranjeProvider() : super("Osiguranje");

  @override
  Osiguranje fromJson(data) {
    return Osiguranje.fromJson(data);
  }
}
