import 'dart:convert';

import 'package:ekarton_admin/models/doktor.dart';
import 'package:ekarton_admin/models/korisnik.dart';
import 'package:ekarton_admin/models/pacijent.dart';
import 'package:ekarton_admin/models/pacijent_osiguranje.dart';
import 'package:ekarton_admin/models/search_result.dart';
import 'package:ekarton_admin/providers/base_provider.dart';
import 'package:ekarton_admin/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class PacijentOsiguranjeProvider extends BaseProvider<PacijentOsiguranje> {
  PacijentOsiguranjeProvider() : super("PacijentOsiguranje");

  @override
  PacijentOsiguranje fromJson(data) {
    return PacijentOsiguranje.fromJson(data);
  }
}
