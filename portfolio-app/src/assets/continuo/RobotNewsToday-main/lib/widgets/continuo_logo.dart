import 'package:flutter/material.dart';

class ContinuoLogo extends StatefulWidget {
  final double size;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  const ContinuoLogo({super.key, this.size = 120, this.onTap, this.onLongPress});

  @override
  State<ContinuoLogo> createState() => _ContinuoLogoState();
}

class _ContinuoLogoState extends State<ContinuoLogo> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onLongPress: widget.onLongPress,
      child: Container(
        width: widget.size,
        height: widget.size,
        child: Image.asset(
          'assets/logo.png',
          width: widget.size,
          height: widget.size,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
