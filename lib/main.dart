import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simad_mobile_v2/core/theme/theme.dart';
import 'package:simad_mobile_v2/data/repositories/auth_repository.dart';
import 'package:simad_mobile_v2/presentation/auth/bloc/auth_bloc.dart';
import 'package:simad_mobile_v2/presentation/auth/screens/login_screen.dart';
import 'package:simad_mobile_v2/presentation/home/screens/home_screen.dart';
import 'package:simad_mobile_v2/presentation/splash/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );

  final AuthRepository authRepository = AuthRepository();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(authRepository: authRepository),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SIMAD Apps',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: "/",
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case "/":
            return MaterialPageRoute(builder: (_) => const SplashScreen());
          case "/login":
            return MaterialPageRoute(builder: (_) => const LoginScreen());
          case "/home":
            return MaterialPageRoute(builder: (_) => const HomeScreen());
          default:
            return MaterialPageRoute(
              builder: (_) => const Scaffold(
                body: Center(child: Text("Halaman tidak ditemukan!")),
              ),
            );
        }
      },
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (_) => const Scaffold(
          body: Center(child: Text("404 - Route tidak ditemukan!")),
        ),
      ),
    );
  }
}
