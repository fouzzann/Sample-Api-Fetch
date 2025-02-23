import 'dart:convert';

import 'package:sample_api_practice/model/api_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static String apiUrl = "https://meetingapi.infolksgroup.com/api/user";
  static String loginUrl ='https://reqres.in/api/register';


  static Future<List<User>> fetchUser() async {
    try {
      final response = await http.get(Uri.parse(apiUrl), headers: {
        "Access": "application/json",
        "Content-Type": "application/json",
      });

      switch (response.statusCode) {
        case 200:
          final List<dynamic> decodedData = json.decode(response.body);
          return decodedData.map((json) => User.fromJson(json)).toList();
        // Bad Request
        case 400:
          throw Exception(
              'Bad Request - Please check your input data and try again. There seems to be an issue with the information you provided');
        // Unauthorized
        case 401:
          throw Exception(
              'Unauthorized: Please check your login credentials and try again');
        // Access Denied
        case 403:
          throw Exception(
              'Access Denied: You do not have permission to access this resource');
        // Page Not Found
        case 404:
          throw Exception(
              """Page Not Found," "Oops, looks like you've stumbled upon a missing page," or "The requested page could not be found""");
        // something went wrong
        case 500:
          throw Exception('Oops, something went wrong on our end. Please try again later');
        // Service Unavailable
        case 503:
          throw Exception('Service Unavailable - Our server is currently experiencing high traffic and is temporarily unable to process your request. Please try again later.');
        // default message
        default:
          throw Exception('An unexpected error occurred on the server. Please try again later.');
      }
    } catch (e) {
      throw Exception("Exception $e");
    }
  }
 static Future<bool> login(String email, String password) async {
  try {
    final response = await http.post(
      Uri.parse(loginUrl),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
      body: json.encode({
        "email": email,
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      print("✅ Login Successful: ${response.body}"); 
      return true;  // Return true for success
    } else {
      print("❌ Login Failed: ${response.statusCode} - ${response.body}");
      return false; // Return false for failure
    }
  } catch (e) {
    print("⚠️ Error: $e");
    return false;
  }
}


}
