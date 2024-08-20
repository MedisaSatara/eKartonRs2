import 'dart:convert';

import 'package:ekarton_admin/models/odjel.dart';
import 'package:ekarton_admin/models/pacijent.dart';
import 'package:ekarton_admin/models/preventivne_mjere.dart';
import 'package:ekarton_admin/models/search_result.dart';
import 'package:ekarton_admin/providers/base_provider.dart';
import 'package:ekarton_admin/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class PreventivneMjereProvider extends BaseProvider<PreventivneMjere> {
  PreventivneMjereProvider() : super("PreventivneMjere");

  @override
  PreventivneMjere fromJson(data) {
    return PreventivneMjere.fromJson(data);
  }
}
