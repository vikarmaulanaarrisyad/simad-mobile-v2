import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simad_mobile_v2/data/models/responses/login_response.dart';
import 'package:simad_mobile_v2/data/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  bool isPasswordVisible = false;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<CheckAuthStatus>((event, emit) async {
      emit(AuthLoading());
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("token");

      if (token == null) {
        emit(AuthFailure(
            errorMessage: "Token tidak ditemukan, silakan login kembali."));
      } else {
        try {
          final result = await authRepository.getUser();
          emit(AuthGetUser(user: result.user, token: result.token));
        } catch (e) {
          emit(AuthFailure(errorMessage: "Gagal mengambil data pengguna."));
        }
      }
    });

    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final result = await authRepository.login(event.email, event.password);
        await authRepository.saveToken(result.token);
        // print('Token : ${result.token}');
        emit(AuthSuccess(token: result.token));
      } catch (e) {
        // Ambil pesan error dari exception
        String errorMessage =
            "Login gagal, periksa kembali email dan password Anda.";
        if (e is Exception) {
          errorMessage = e.toString().replaceFirst(
              "Exception: ", ""); // Hapus "Exception: " dari pesan
        }

        emit(AuthFailure(errorMessage: errorMessage));
      }
    });

    on<LogoutRequested>((event, emit) async {
      await authRepository.logout();
      emit(AuthInitial());
    });

    on<TogglePasswordVisibility>((event, emit) {
      isPasswordVisible = !isPasswordVisible;
      emit(AuthPasswordVisibility(isPasswordVisible: isPasswordVisible));
    });

    on<GetUserRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final result = await authRepository.getUser();
        emit(AuthGetUser(token: result.token, user: result.user));
      } catch (e) {
        // Jika token expired atau tidak valid, logout otomatis
        if (e.toString().contains("Sesi telah berakhir")) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.remove("token");
          emit(AuthInitial()); // Kembali ke login
        } else {
          emit(AuthFailure(errorMessage: e.toString()));
        }
      }
    });
  }
}
