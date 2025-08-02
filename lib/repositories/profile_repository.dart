import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:movie_case/bloc/toke_storage.dart';

class ProfileRepository {
  final String _uploadUrl =
      "https://caseapi.servicelabs.tech/user/upload_photo";

  Future<void> uploadProfilePhoto(String imagePath) async {
    final token = await TokenStorage.getToken();
    if (token == null) throw Exception("TOKEN_UNAVAILABLE");
    
    var request = http.MultipartRequest('POST', Uri.parse(_uploadUrl));

    request.headers.addAll({
      'Authorization': 'Bearer $token',
      'Content-Type': 'multipart/form-data',
    });

    request.files.add(
      await http.MultipartFile.fromPath(
        'photo', // API'de farklıysa kontrol et
        imagePath,
        contentType: MediaType('image', 'jpeg'),
      ),
    );

    final response = await request.send();
    if (response.statusCode != 200) {
      throw Exception("Fotoğraf yükleme başarısız: ${response.statusCode}");
    }
  }
}
