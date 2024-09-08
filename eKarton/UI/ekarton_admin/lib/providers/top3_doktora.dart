import 'dart:convert';

import 'package:ekarton_admin/models/administrator.dart';
import 'package:ekarton_admin/models/odabrani_doktori.dart';
import 'package:ekarton_admin/models/search_result.dart';
import 'package:ekarton_admin/providers/base_provider.dart';
import 'package:ekarton_admin/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class Top3Doktora extends BaseProvider<OdabraniDoktori> {
  Top3Doktora() : super("Report/top-3-najposjecenija-doktora");

  @override
  OdabraniDoktori fromJson(data) {
    return OdabraniDoktori(
      imeDoktora: data['imeDoktora'],
      specijalizacija: data['specijalizacija'],
      brojZakazanihTermina: data['brojZakazanihTermina'],
    );
  }
}
