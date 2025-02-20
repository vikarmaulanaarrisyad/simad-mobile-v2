import 'package:flutter/material.dart';

enum SnackBarType { success, error, warning, info }

class SnackbarUtil {
  static void show(
    BuildContext context, {
    required String message,
    required SnackBarType type,
  }) {
    final Color backgroundColor;
    final IconData icon;

    switch (type) {
      case SnackBarType.success:
        backgroundColor = Colors.green;
        icon = Icons.check_circle_outline;
        break;
      case SnackBarType.error:
        backgroundColor = Colors.red;
        icon = Icons.error_outline;
        break;
      case SnackBarType.warning:
        backgroundColor = Colors.orange;
        icon = Icons.warning_amber_rounded;
        break;
      case SnackBarType.info:
        backgroundColor = Colors.blue;
        icon = Icons.info_outline;
        break;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
