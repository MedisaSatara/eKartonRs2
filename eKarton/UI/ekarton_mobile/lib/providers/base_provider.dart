import 'dart:convert';
import 'package:ekarton_mobile/models/doktor.dart';
import 'package:ekarton_mobile/models/search_result.dart';
import 'package:ekarton_mobile/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

abstract class BaseProvider<T> with ChangeNotifier {
  static String? _baseUrl;
  String _endpoint;
  String? totalUrl;

  BaseProvider(String endpoint) : _endpoint = endpoint {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "http://192.168.0.106:7073/");
    totalUrl = "$_baseUrl$_endpoint";
  }
  //http://192.168.0.106:7073/
  //https://localhost:7285/
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

    String basicAuth =
        "Basic ${base64Encode(utf8.encode('$username:$password'))}";

    return {
      "Content-Type": "application/json",
      "Authorization": basicAuth,
    };
  }

  final String apiUrl = 'http://192.168.0.106:7073/Doktor/preporuceni';
  //final String apiUrl = 'https://localhost:7285/Doktor/preporuceni';

  Future<List<Doktor>> fetchRecommendedDoctors() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Doktor.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load recommended doctors');
    }
  }

  Future<Map<String, dynamic>> fetchRecommendedDoctor() async {
    final response = await http.get(
      Uri.parse('http://192.168.0.106:7073/Doktor/preporuceni'),
      headers: {
        'Authorization': 'Basic YWRtaW46dGVzdA==',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final averageRating = data['averageRating'];
      final doctors = (data['doctors'] as List)
          .map((item) => Doktor.fromJson(item))
          .toList();

      return {
        'averageRating': averageRating,
        'doctors': doctors,
      };
    } else {
      throw Exception('Failed to load recommended doctors');
    }
  }
}
