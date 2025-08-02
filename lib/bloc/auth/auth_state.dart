part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

// Başlangıç durumu (henüz hiçbir işlem yapılmadı)
class AuthInitial extends AuthState {}

// Giriş işlemi başladığında (UI'da loading indicator göstermek için)
class AuthLoading extends AuthState {}

// Giriş başarılı olduğunda (Kullanıcı verisini UI'a taşır)
class AuthAuthenticated extends AuthState {
  final UserData userData;

  const AuthAuthenticated({required this.userData});

  @override
  List<Object?> get props => [userData];
}

class AuthUnauthenticated extends AuthState {}

// Giriş başarısız olduğunda (Hata mesajını UI'a taşır)
class AuthFailure extends AuthState {
  final String error;

  const AuthFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
