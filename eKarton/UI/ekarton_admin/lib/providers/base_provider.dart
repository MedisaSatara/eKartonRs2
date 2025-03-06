import 'dart:convert';
import 'package:ekarton_admin/models/bolesti_po_godistu_report.dart';
import 'package:ekarton_admin/models/doktori_pregled_report.dart';
import 'package:ekarton_admin/models/korisnik_uloga.dart';
import 'package:ekarton_admin/models/odabrani_doktori.dart';
import 'package:ekarton_admin/models/search_result.dart';
import 'package:ekarton_admin/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

abstract class BaseProvider<T> with ChangeNotifier {
  static String? _baseUrl;
  String _endpoint;
  String? totalUrl;

  BaseProvider(String endpoint) : _endpoint = endpoint {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "http://localhost:7073/");
    totalUrl = "$_baseUrl$_endpoint";
  }
  //https://localhost:7285/
  //http://localhost:7073/
  Future<SearchResult<T>> get({dynamic filter}) async {
    var url = "$_baseUrl$_endpoint";

    if (filter != null) {
      var queryString = getQueryString(filter);
      url = "$url?$queryString";
    }

    var uri = Uri.parse(url);
    var headers = createHeaders();

    try {
      var response = await http.get(uri, headers: headers);

      if (isValidResponse(response)) {
        var data = jsonDecode(response.body);
        var result = SearchResult<T>();
        result.count = data['count'];
        for (var item in data['result']) {
          result.result.add(fromJson(item));
        }
        return result;
      } else {
        throw Exception("Unknown error");
      }
    } catch (e) {
      print("Error during GET request: $e");
      rethrow;
    }
  }

  T fromJson(dynamic data);

  Future<T> update(int id, [dynamic request]) async {
    var url = "$_baseUrl$_endpoint/$id";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    try {
      var jsonRequest = jsonEncode(request);
      var response = await http.put(uri, headers: headers, body: jsonRequest);

      if (isValidResponse(response)) {
        var data = jsonDecode(response.body);
        return fromJson(data);
      } else {
        throw Exception("Unknown error");
      }
    } catch (e) {
      print("Error during PUT request: $e");
      rethrow;
    }
  }

  Future<T> insert(dynamic request) async {
    var url = "$_baseUrl$_endpoint";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    try {
      var jsonRequest = jsonEncode(request);
      print("Request URL: $url");
      print("Request Headers: $headers");
      print("Request Body: $jsonRequest");

      var response = await http.post(uri, headers: headers, body: jsonRequest);

      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (isValidResponse(response)) {
        var data = jsonDecode(response.body);
        return fromJson(data);
      } else {
        throw Exception("Error: ${response.statusCode} ${response.body}");
      }
    } catch (e) {
      print("Error during POST request: $e");
      rethrow;
    }
  }

  Future<T> delete(int? id) async {
    var url = "$_baseUrl$_endpoint/$id";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    Response response = await http.delete(uri, headers: headers);

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      notifyListeners();
      return fromJson(data);
    } else {
      throw Exception("Unknown error");
    }
  }

  String getQueryString(Map params,
      {String prefix = '&', bool inRecursion = false}) {
    String query = '';
    params.forEach((key, value) {
      if (inRecursion) {
        key = (key is int) ? '[$key]' : '.$key';
      }
      if (value is String || value is int || value is double || value is bool) {
        var encoded = Uri.encodeComponent(value.toString());
        query += '$prefix$key=$encoded';
      } else if (value is DateTime) {
        query += '$prefix$key=${(value as DateTime).toIso8601String()}';
      } else if (value is List || value is Map) {
        if (value is List) value = value.asMap();
        value.forEach((k, v) {
          query +=
              getQueryString({k: v}, prefix: '$prefix$key', inRecursion: true);
        });
      }
    });
    return query;
  }

  bool isValidResponse(Response response) {
    if (response.statusCode < 300) {
      return true;
    } else if (response.statusCode == 401) {
      throw Exception("Unauthorized");
    } else {
      print(response.body);
      throw Exception("Something bad happened, please try again");
    }
  }

  Map<String, String> createHeaders() {
    String username = Authorization.username ?? "";
    String password = Authorization.password ?? "";

    print("Passed credentials: $username, $password");

    String Basic = "Basic ${base64Encode(utf8.encode('$username:$password'))}";

    return {
      "Content-Type": "application/json",
      "Authorization": Basic,
    };
  }

  Future<List<OdabraniDoktori>> fetchTop3Doktora() async {
    var url = totalUrl ?? "$_baseUrl$_endpoint";

    var uri = Uri.parse(url);
    var headers = createHeaders();

    try {
      var response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);

        List<OdabraniDoktori> doktorReports =
            body.map((dynamic item) => OdabraniDoktori.fromJson(item)).toList();

        return doktorReports;
      } else {
        throw Exception('Failed to load report data: ${response.statusCode}');
      }
    } catch (e) {
      print("Error fetching report data: $e");
      throw Exception('Failed to load report data');
    }
  }

  Future<List<DoktoriPregledReport>> fetchPreglediPoDoktoru({
    DateTime? startDate,
    DateTime? endDate,
    int? month,
    int? year,
  }) async {
    var url = totalUrl ?? "$_baseUrl$_endpoint";

    if (startDate != null || endDate != null || month != null || year != null) {
      var queryString = getQueryString({
        'startDate': startDate?.toIso8601String(),
        'endDate': endDate?.toIso8601String(),
        'month': month,
        'year': year,
      });
      url = "$url?$queryString";
    }

    var uri = Uri.parse(url);
    var headers = createHeaders();

    try {
      var response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        List<DoktoriPregledReport> reportList = body
            .map((dynamic item) => DoktoriPregledReport.fromJson(item))
            .toList();
        return reportList;
      } else {
        throw Exception('Failed to load PreglediPoDoktoruReport data');
      }
    } catch (e) {
      print("Error fetching report data: $e");
      throw Exception('Failed to load PreglediPoDoktoruReport data');
    }
  }

  Future<List<BolestiPoGodistuReport>> fetchBolestiPoGodistuReport() async {
    var url = totalUrl ?? "$_baseUrl$_endpoint";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    try {
      var response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        List<BolestiPoGodistuReport> reportList = body
            .map((dynamic item) => BolestiPoGodistuReport.fromJson(item))
            .toList();
        return reportList;
      } else {
        throw Exception('Failed to load BolestiPoGodistuReport data');
      }
    } catch (e) {
      print("Error fetching report data: $e");
      throw Exception('Failed to load BolestiPoGodistuReport data');
    }
  }

  Future<bool> provjeriStaruLozinku(int korisnikId, String staraLozinka) async {
    String url = totalUrl ?? "$_baseUrl$_endpoint";

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "korisnikId": korisnikId,
          "staraLozinka": staraLozinka,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as bool;
      } else {
        print("Greška: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("Greška: $e");
      return false;
    }
  }

  Future<bool> checkOldPassword(int korisnikId, String oldPassword) async {
    final url = totalUrl ?? "$_baseUrl$_endpoint";

    // final url = Uri.parse('https://localhost:7285/Korisnik/provjeriLozinku');

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'korisnikId': korisnikId,
        'staraLozinka': oldPassword,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['isPasswordCorrect'] ?? false;
    } else {
      throw Exception('Failed to check password');
    }
  }

  Future<T> getById(int? id) async {
    var url = "$_baseUrl$_endpoint/$id";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    Response response = await http.get(uri, headers: headers);
    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      return fromJson(data);
    } else {
      throw Exception("Unknown error");
    }
  }

  Future<SearchResult<KorisnikUloga>> getKorisnikUloga(
      {Map<String, String>? filter}) async {
    final response = await http.get(
      Uri.parse('https://localhost:7285/KorisnikUloga'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var filteredData = data.where((item) {
        return item['korisnikId'] == filter?['korisnikId'] &&
            item['ulogaId'] == filter?['ulogaId'];
      }).toList();

      return SearchResult<KorisnikUloga>();
    } else {
      throw Exception('Failed to load data');
    }
  }
}
