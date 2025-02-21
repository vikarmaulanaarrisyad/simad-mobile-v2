import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simad_mobile_v2/data/models/responses/login_response.dart';
import 'package:simad_mobile_v2/presentation/auth/bloc/auth_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<AuthBloc>()
        .add(CheckAuthStatus()); // Cek token saat aplikasi dimulai
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthBloc>().add(LogoutRequested());
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            Navigator.pushReplacementNamed(context, "/login");
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AuthGetUser) {
              User user = state.user;
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Selamat datang, ${user.name}!",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text("Email: ${user.email}",
                        style: const TextStyle(fontSize: 16)),
                  ],
                ),
              );
            } else {
              return const Center(child: Text("Gagal memuat data pengguna."));
            }
          },
        ),
      ),
    );
  }
}
