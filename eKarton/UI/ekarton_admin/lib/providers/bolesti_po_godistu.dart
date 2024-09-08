import 'dart:convert';

import 'package:ekarton_admin/models/administrator.dart';
import 'package:ekarton_admin/models/bolesti_po_godistu_report.dart';
import 'package:ekarton_admin/models/odabrani_doktori.dart';
import 'package:ekarton_admin/models/search_result.dart';
import 'package:ekarton_admin/providers/base_provider.dart';
import 'package:ekarton_admin/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class BolestiPoGodistu extends BaseProvider<BolestiPoGodistuReport> {
  BolestiPoGodistu() : super("Report/bolesti-po-godistu");

  @override
  BolestiPoGodistuReport fromJson(data) {
    return BolestiPoGodistuReport(
      decade: data['decade'],
      najcesceBolesti: data['najcesceBolesti'],
    );
  }
}
