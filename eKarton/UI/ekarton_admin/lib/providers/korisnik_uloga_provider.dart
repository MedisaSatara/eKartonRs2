import 'dart:convert';

import 'package:ekarton_admin/models/korisnik_uloga.dart';
import 'package:ekarton_admin/models/uloga.dart';
import 'package:ekarton_admin/providers/base_provider.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class KorisnikUlogaProvider extends BaseProvider<KorisnikUloga> {
  KorisnikUlogaProvider() : super("KorisnikUloga");

  @override
  KorisnikUloga fromJson(data) {
    return KorisnikUloga.fromJson(data);
  }

  
}
