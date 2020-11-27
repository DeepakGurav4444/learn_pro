import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkHandler {
  String baseUrl = "https://studeebee.in/api";

  Future get(String url) async {
    url = formatter(url);
    var response = await http.get(url);
    return json.decode(response.body);
  }

  Future<http.Response> post(String url, Map<String, String> body) async {
    url = formatter(url);
    var response = await http.post(url,
        headers: {"content-type": "application/json"}, body: json.encode(body));
    return response;
  }

  String formatter(String url) {
    return baseUrl + url;
  }
}
