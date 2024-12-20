import 'dart:convert';

import 'package:ekarton_admin/models/odjel.dart';
import 'package:ekarton_admin/models/pacijent.dart';
import 'package:ekarton_admin/models/search_result.dart';
import 'package:ekarton_admin/models/tehnicka_podrska.dart';
import 'package:ekarton_admin/providers/base_provider.dart';
import 'package:ekarton_admin/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class TehnickaPodrskaProvider extends BaseProvider<TehnickaPodrska> {
  TehnickaPodrskaProvider() : super("TehnickaPodrska");

  @override
  TehnickaPodrska fromJson(data) {
    return TehnickaPodrska.fromJson(data);
  }
}
