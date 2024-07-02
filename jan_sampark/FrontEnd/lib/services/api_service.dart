import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'http://localhost:3000';

  Future<String> register(String username, String password, String email, String role) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
        'email': email,
        'role': role,
      }),
    );

    if (response.statusCode == 201) {
      return 'User created';
    } else {
      throw Exception('Failed to create user');
    }
  }

  Future<String> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      return jsonResponse['token'];
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<List<dynamic>> getGrievances() async {
    final response = await http.get(Uri.parse('$baseUrl/grievances'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load grievances');
    }
  }
}
