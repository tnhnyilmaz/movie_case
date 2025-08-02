import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_case/bloc/toke_storage.dart';
import 'package:movie_case/models/user_model.dart';

class AuthRepository {
  final String _loginUrl = "https://caseapi.servicelabs.tech/user/login";
  final String _registerUrl = "https://caseapi.servicelabs.tech/user/register";
  final String _profileUrl = "https://caseapi.servicelabs.tech/user/profile";

  Future<UserData> login(String email, String password) async {

    final response = await http.post(
      Uri.parse(_loginUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'email': email, 'password': password}),
    );
    if (response.statusCode == 200) {
      final apiResponse = ApiResponse.fromJson(jsonDecode(response.body));
      await TokenStorage.saveToken(apiResponse.data.token);
      print("token ${apiResponse.data.token}");
      return apiResponse.data;
    } else {
      throw Exception(
        'Giriş başarısız oldu. Hata kodu: ${response.statusCode}',
      );
    }
  }

  Future<UserData> register(String email, String name, String password) async {
    final response = await http.post(
      Uri.parse(_registerUrl),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode({'email': email, 'name': name, 'password': password}),
    );
    if (response.statusCode == 200) {
      final apiResponse = ApiResponse.fromJson(jsonDecode(response.body));
      await TokenStorage.saveToken(apiResponse.data.token);
      return apiResponse.data;
    } else {
      throw Exception(
        'Kayıt başarısız oldu. Hata kodu: ${response.statusCode}',
      );
    }
  }

  Future<UserData> getProfile() async {
    final token = await TokenStorage.getToken();
    if (token == null) throw Exception("TOKEN_UNAVAILABLE");

    final response = await http.get(
      Uri.parse(_profileUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final apiResponse = ApiResponse.fromJson(jsonDecode(response.body));
      print(apiResponse.data);
      return apiResponse.data;
    } else if (response.statusCode == 400) {
      final responseBody = jsonDecode(response.body);
      if (responseBody['message'] == "TOKEN_UNAVAILABLE") {
        throw Exception("TOKEN_UNAVAILABLE");
      }
      throw Exception("Profil alınamadı: ${response.body}");
    } else {
      throw Exception("Profil alınamadı: ${response.body}");
    }
  }
}
