import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/compte_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiService {
  String baseUrl;

  FlutterSecureStorage secureStorage;

  ApiService(this.baseUrl, this.secureStorage);

  Future<void> register(Compte compte) async {
    final response = await http.post(
      Uri.parse('$baseUrl/compte/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(compte.toJson()),
    );

    if (response.statusCode == 200) {
      // Gérer la réponse réussie
    } else {
      // Gérer les erreurs
    }
  }

  Future<String?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/compte/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'motDePasse': password}),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final String accessToken = responseData['access_token'];
      return accessToken;
    } else {
      throw Exception('Failed to log in');
    }
  }



  Future<void> confirmRegister(String email, String confirmationCode, String numTel, String motDePasse, String categorie) async {
    final response = await http.post(
      Uri.parse('$baseUrl/compte/confirm_register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'confirmation_token': confirmationCode,
        'numTel': numTel,
        'motDePasse': motDePasse,
        'categorie': categorie,
      }),
    );

    if (response.statusCode == 200) {
      // Gérer la confirmation réussie
    } else {
      // Gérer les erreurs
    }
  }


  Future<Map<String, dynamic>> getUserProfile() async {
    final String? accessToken = await secureStorage.read(key: 'access_token');

    if (accessToken != null) {
      final response = await http.get(
        Uri.parse('$baseUrl/compte/protected'),
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 200) {
        print('User Profile Response: ${response.body}');
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to fetch user profile. Status code: ${response.statusCode}');
      }
    } else {
      throw Exception('Access token not found');
    }
  }


}
