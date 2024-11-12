import 'dart:convert';

import 'package:ekarton_admin/models/administrator.dart';
import 'package:ekarton_admin/providers/base_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class AdministratorProvider extends BaseProvider<Administrator> {
  AdministratorProvider() : super("Administrator");

  @override
  Administrator fromJson(data) {
    return Administrator.fromJson(data);
  }
}
