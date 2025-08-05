import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_case/bloc/toke_storage.dart';
import 'package:movie_case/models/movie_model.dart';
import 'package:movie_case/models/movie_response.dart';

class MovieRepository {
  final String _baseUrl = "https://caseapi.servicelabs.tech/movie/list";

  Future<MovieResponse> fetchMovies(int page) async {
    final token = await TokenStorage.getToken();
    if (token == null) {
      throw Exception("Yetkilendirme token'ı bulunamadı.");
    }

    final uri = Uri.parse("$_baseUrl?page=$page");

    final response = await http.get(
      uri,
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );

    print("URL: $uri");
    print("Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      try {
        final jsonBody = jsonDecode(response.body);
        return MovieResponse.fromJson(jsonBody);
      } on FormatException catch (e) {
        throw Exception("API yanıtı hatalı formatta: $e");
      } catch (e) {
        throw Exception("API yanıtı işlenirken bir sorun oluştu: $e");
      }
    } else if (response.statusCode == 401) {
      throw Exception("Geçersiz token. Lütfen tekrar giriş yapın.");
    } else {
      throw Exception("Filmler alınamadı: ${response.statusCode}");
    }
  }

  Future<void> addToFavorite(String favoriteId) async {
    final token = await TokenStorage.getToken();
    if (token == null) {
      throw Exception("Yetkilendirme token'ı bulunamadı.");
    }

    final uri = Uri.parse(
      "https://caseapi.servicelabs.tech/movie/favorite/$favoriteId",
    );

    final response = await http.post(
      uri,
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );

    print("Favoriye Ekleme Status: ${response.statusCode}");
    print("Response: ${response.body}");

    if (response.statusCode != 200) {
      throw Exception("Favoriye eklenemedi: ${response.statusCode}");
    }
  }

  Future<List<Movie>> fetchFavoriteMovies() async {
    final token = await TokenStorage.getToken();
    if (token == null) {
      throw Exception("Yetkilendirme token'ı bulunamadı.");
    }

    final uri = Uri.parse("https://caseapi.servicelabs.tech/movie/favorites");

    final response = await http.get(
      uri,
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );

    print("Favoriler Status: ${response.statusCode}");
    print("Body: ${response.body}");

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      if (jsonData is List) {
        return jsonData.map((e) => Movie.fromJson(e)).toList();
      }

      final List<dynamic> moviesJson = jsonData["movies"] ?? jsonData["data"];
      return moviesJson.map((e) => Movie.fromJson(e)).toList();
    } else {
      throw Exception("Favori filmler alınamadı: ${response.statusCode}");
    }
  }
}
