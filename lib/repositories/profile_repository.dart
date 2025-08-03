import 'dart:convert'; // JSON parse için gerekli

import 'package:http/http.dart' as http;
import 'package:movie_case/bloc/toke_storage.dart';

class ProfileRepository {
  final String _uploadUrl =
      "https://caseapi.servicelabs.tech/user/upload_photo";

  // Metodun dönüş tipini Future<String> yapıyoruz
  Future<String> uploadProfilePhoto(String imagePath) async {
    final token = await TokenStorage.getToken();
    if (token == null) throw Exception("TOKEN_UNAVAILABLE");

    var request = http.MultipartRequest('POST', Uri.parse(_uploadUrl));
    request.headers.addAll({'Authorization': 'Bearer $token'});

    // Buradaki 'photo' alan adını, eğer Swagger'da farklı bir ad kullandıysanız,
    // onunla değiştirmeniz gerektiğini unutmayın.
    request.files.add(await http.MultipartFile.fromPath('file', imagePath));

    final response = await request.send();
    final responseBody = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      // Yanıt gövdesini ayrıştırıyoruz
      final decodedResponse = json.decode(responseBody);

      // photoUrl değerini alıyoruz
      final imageUrl = decodedResponse['data']['photoUrl'] as String;

      // Alınan URL'yi döndürüyoruz
      return imageUrl;
    } else {
      print("Sunucudan Gelen Hata (${response.statusCode}): $responseBody");
      throw Exception("Fotoğraf yükleme başarısız: ${response.statusCode}");
    }
  }
}
