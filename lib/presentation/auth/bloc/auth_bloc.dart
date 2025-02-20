import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:simad_mobile_v2/data/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final loginResponse =
            await authRepository.login(event.email, event.password);
        await authRepository.saveToken(loginResponse.token);
        emit(AuthSuccess(token: loginResponse.token));
      } catch (e) {
        emit(AuthFailure(
            errorMessage:
                "Login gagal, periksa kembali email dan password Anda."));
      }
    });

    on<LogoutRequested>((event, emit) async {
      await authRepository.logout();
      emit(AuthInitial());
    });
  }
}
