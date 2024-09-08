import 'dart:convert';

import 'package:ekarton_admin/models/administrator.dart';
import 'package:ekarton_admin/models/doktori_pregled_report.dart';
import 'package:ekarton_admin/models/odabrani_doktori.dart';
import 'package:ekarton_admin/models/search_result.dart';
import 'package:ekarton_admin/providers/base_provider.dart';
import 'package:ekarton_admin/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class DoktoriPregled extends BaseProvider<DoktoriPregledReport> {
  DoktoriPregled() : super("Report/pregledi-po-doktoru");

  @override
  DoktoriPregledReport fromJson(data) {
    return DoktoriPregledReport(
      imeDoktora: data['imeDoktora'],
      specijalizacija: data['specijalizacija'],
      brojPregleda: data['brojPregleda'],
      brojPacijenata: data['brojPacijenata'],
    );
  }
}
