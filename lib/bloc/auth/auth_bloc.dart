import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_case/models/user_model.dart';
import 'package:movie_case/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<LoginRequested>((event, emit) async {
      // Önce yükleniyor durumunu yayınla
      emit(AuthLoading());
      try {
        // Repository üzerinden giriş yapmayı dene
        final userData = await authRepository.login(
          event.email,
          event.password,
        );
        // Başarılı olursa, kullanıcı bilgileriyle birlikte AuthAuthenticated durumunu yayınla
        emit(AuthAuthenticated(userData: userData));
      } catch (e) {
        // Hata olursa, hata mesajıyla birlikte AuthFailure durumunu yayınla
        emit(AuthFailure(error: e.toString()));
      }
    });

    on<RegisterRequested>((event, emit) async {
      emit(AuthLoading());

      try {
        final userData = await authRepository.register(
          event.email,
          event.name,
          event.password,
        );
        emit(AuthAuthenticated(userData: userData));
      } catch (e) {
        emit(AuthFailure(error: e.toString()));
      }
    });

    on<GetProfileRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final userData = await authRepository.getProfile();
        emit(AuthAuthenticated(userData: userData));
      } catch (e) {
        if (e.toString().contains("TOKEN_UNAVAILABLE")) {
          emit(AuthUnauthenticated());
        } else {
          emit(AuthFailure(error: e.toString()));
        }
      }
    });
  }
}
