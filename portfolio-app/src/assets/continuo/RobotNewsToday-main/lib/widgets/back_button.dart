import 'package:flutter/material.dart';
import '../utils/theme.dart';

class BackButtonTopBar extends StatelessWidget {
  final VoidCallback? onPressed;
  const BackButtonTopBar({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed ?? () => Navigator.of(context).maybePop(),
      style: TextButton.styleFrom(
        foregroundColor: continuoBlue,
        textStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.arrow_back, color: continuoBlue, size: 28),
          SizedBox(width: 8),
          Text('Back'),
        ],
      ),
    );
  }
}
