import 'package:flutter/material.dart';

class PasswordStrengthIndicator extends StatelessWidget {
  final String password;

  const PasswordStrengthIndicator({super.key, required this.password});

  double _calculateStrength(String password) {
    if (password.isEmpty) return 0.0;
    double strength = 0.0;
    if (password.length > 6) strength += 0.25;
    if (password.length > 9) strength += 0.25;
    if (password.contains(RegExp(r'[A-Z]'))) strength += 0.25;
    if (password.contains(RegExp(r'[0-9]')) ||
        password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      strength += 0.25;
    }
    return strength;
  }

  Color _getColor(double strength) {
    if (strength <= 0.25) return Colors.red;
    if (strength <= 0.5) return Colors.orange;
    if (strength <= 0.75) return Colors.yellow;
    return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    final strength = _calculateStrength(password);
    final color = _getColor(strength);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LinearProgressIndicator(
          value: strength,
          backgroundColor: Colors.grey.shade300,
          color: color,
          minHeight: 5,
        ),
        const SizedBox(height: 4),
        Text(
          strength < 0.3
              ? 'Slabé heslo'
              : (strength < 0.7 ? 'Střední' : 'Silné heslo'),
          style: TextStyle(color: color, fontSize: 12),
        ),
      ],
    );
  }
}
