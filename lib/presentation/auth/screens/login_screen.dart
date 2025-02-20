import 'package:flutter/material.dart';
import 'package:simad_mobile_v2/core/theme/theme.dart';
import 'package:simad_mobile_v2/presentation/auth/widgets/login_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenHeight,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: screenHeight * 0.35,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: AppTheme.primaryGradient,
                      begin: Alignment.bottomLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                  ),
                  child: const Stack(
                    children: [
                      Positioned(
                        top: -50,
                        right: -50,
                        child: QClippart(),
                      ),
                      Positioned(
                        top: 40,
                        left: 16,
                        right: 16,
                        child: Row(
                          children: [
                            Expanded(
                              child: Center(
                                child: Text(
                                  'Welcome back',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 40.0),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: screenHeight * 0.20,
                left: 24,
                right: 24,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: LoginForm(
                    formKey: formKey,
                    emailController: emailController,
                    passwordController: passwordController,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class QClippart extends StatelessWidget {
  const QClippart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(0.1),
      ),
    );
  }
}
