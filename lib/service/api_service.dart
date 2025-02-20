import 'dart:convert';

import 'package:sample_api_practice/model/api_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static String apiUrl = "https://meetingapi.infolksgroup.com/api/user";
  static Future<List<User>> fetchUser() async {
    try {
      final response = await http.get(Uri.parse(apiUrl), headers: {
        'Access': 'application/json',
        'Content-Type': 'application/json',
      });

      switch (response.statusCode) {
        case 200:
          final List<dynamic> decodeData = json.decode(response.body);
          return decodeData.map((json) => User.formJson(json)).toList();

        case 400:
          throw Exception('');

        case 401:
          throw Exception('');

        case 403:
          throw Exception('');

        case 404:
          throw Exception('');

        case 500:
          throw Exception('');

        case 503:
          throw Exception('');

        default:
          throw Exception('');
      }
    } catch (e) {}
    throw Exception('');
  }
}
