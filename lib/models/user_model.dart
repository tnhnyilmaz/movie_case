import 'package:equatable/equatable.dart';

// API'den gelen genel cevabı modelleyen sınıf
class ApiResponse {
  final UserData data;

  ApiResponse({required this.data});

  // JSON'dan nesneye dönüştürme
  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(data: UserData.fromJson(json['data']));
  }
}

// "data" nesnesini modelleyen sınıf
class UserData extends Equatable {
  final String id;
  final String name;
  final String email;
  final String photoUrl;
  final String token;

  const UserData({
    required this.id,
    required this.name,
    required this.email,
    required this.photoUrl,
    required this.token,
  });

  // JSON'dan nesneye dönüştürme
  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      photoUrl: json['photoUrl'],
      token: json['token'],
    );
  }

  // Equatable için gerekli olan props listesi
  @override
  List<Object?> get props => [id, name, email, photoUrl, token];
}
