import 'package:flutter/material.dart';
import 'package:simad_mobile_v2/core/theme/theme.dart';

import 'package:simad_mobile_v2/core/utils/validators/validator.dart';
import 'package:simad_mobile_v2/presentation/auth/screens/forgot_password.dart';
import 'package:simad_mobile_v2/presentation/auth/widgets/q_text_field.dart';
import 'package:simad_mobile_v2/core/components/gradient_button.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required this.formKey,
    required this.emailController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Login to your account',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            'Enter your credentials to Attendace',
            style: TextStyle(
              fontSize: 14,
              color: AppTheme.textSecondary,
            ),
          ),
          const SizedBox(
            height: 32.0,
          ),
          QTextField(
            label: "Email",
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            validator: (value) => TValidator.validateEmail(value),
            controller: emailController,
          ),
          QTextField(
            label: "Password",
            prefixIcon: Icons.lock_outline,
            isPassword: true,
            validator: (value) => TValidator.validatePassoword(value),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ForgotPassword(),
                  ),
                );
              },
              style: TextButton.styleFrom(
                foregroundColor: AppTheme.textSecondary,
              ),
              child: const Text('Lupa Password'),
            ),
          ),
          const SizedBox(height: 24.0),
          GradientButton(
            text: "Login",
            onPressed: () {
              if (formKey.currentState!.validate()) {
                // Handle login logic here
              }
            },
          ),
          const SizedBox(height: 24.0),
          const Center(
            child: Text(
              "Version 1.0.0",
              style: TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 14,
              ),
            ),
          )
        ],
      ),
    );
  }
}
