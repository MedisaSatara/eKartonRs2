import 'dart:convert';

import 'package:ekarton_mobile/models/preventivne_mjere.dart';
import 'package:ekarton_mobile/providers/base_provider.dart';
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
