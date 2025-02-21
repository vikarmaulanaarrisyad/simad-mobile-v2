import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simad_mobile_v2/core/theme/theme.dart';
import 'package:simad_mobile_v2/presentation/auth/bloc/auth_bloc.dart';

class QTextField extends StatelessWidget {
  final String label;
  final IconData prefixIcon;
  final bool isPassword;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  const QTextField({
    super.key,
    required this.label,
    required this.prefixIcon,
    this.isPassword = false,
    this.keyboardType,
    this.validator,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        bool isPasswordVisible = false;
        if (state is AuthPasswordVisibility) {
          isPasswordVisible = state.isPasswordVisible;
        }

        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppTheme.primaryColor.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 5),
              )
            ],
          ),
          child: TextFormField(
            controller: controller,
            obscureText: isPassword ? !isPasswordVisible : false,
            keyboardType: keyboardType,
            validator: validator,
            style: const TextStyle(
              color: AppTheme.textPrimary,
              fontSize: 16,
            ),
            decoration: InputDecoration(
              label: Text(label),
              labelStyle: const TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 14,
              ),
              prefixIcon: Icon(
                prefixIcon,
                color: AppTheme.primaryColor,
              ),
              suffixIcon: isPassword
                  ? IconButton(
                      icon: Icon(
                        isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        context
                            .read<AuthBloc>()
                            .add(TogglePasswordVisibility());
                      },
                      color: AppTheme.primaryColor,
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide:
                    const BorderSide(color: AppTheme.primaryColor, width: 2),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                    color: AppTheme.textSecondary.withOpacity(0.1), width: 1),
              ),
            ),
          ),
        );
      },
    );
  }
}
