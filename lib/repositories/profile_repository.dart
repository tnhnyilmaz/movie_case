import 'dart:convert'; 

import 'package:http/http.dart' as http;
import 'package:movie_case/bloc/toke_storage.dart';

class ProfileRepository {
  final String _uploadUrl =
      "https://caseapi.servicelabs.tech/user/upload_photo";

  Future<String> uploadProfilePhoto(String imagePath) async {
    final token = await TokenStorage.getToken();
    if (token == null) throw Exception("TOKEN_UNAVAILABLE");

    var request = http.MultipartRequest('POST', Uri.parse(_uploadUrl));
    request.headers.addAll({'Authorization': 'Bearer $token'});


    request.files.add(await http.MultipartFile.fromPath('file', imagePath));

    final response = await request.send();
    final responseBody = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      final decodedResponse = json.decode(responseBody);

      final imageUrl = decodedResponse['data']['photoUrl'] as String;

      return imageUrl;
    } else {
      print("Sunucudan Gelen Hata (${response.statusCode}): $responseBody");
      throw Exception("Fotoğraf yükleme başarısız: ${response.statusCode}");
    }
  }
}
