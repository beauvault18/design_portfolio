import 'package:flutter/material.dart';
import '../utils/theme.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final VoidCallback? onTap;
  final double width;
  final double height;
  final Color? backgroundColor;
  final Color? textColor;
  final bool bold;
  final double borderRadius;
  final double fontSize;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  const CustomButton({
    super.key,
    required this.text,
    this.onTap,
    this.width = 420,
    this.height = 72,
    this.backgroundColor,
    this.textColor,
    this.bold = true,
    this.borderRadius = 12,
    this.fontSize = 22,
    this.margin,
    this.padding,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final bg = widget.backgroundColor ?? continuoBlue;
    final txt = widget.textColor ?? Colors.white;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedScale(
        scale: _hovering ? 1.05 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: GestureDetector(
          onTap: widget.onTap,
          child: Container(
            width: widget.width,
            height: widget.height,
            margin: widget.margin,
            padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              color: _hovering ? bg.withOpacity(0.92) : bg,
              borderRadius: BorderRadius.circular(widget.borderRadius),
              boxShadow: _hovering
                  ? [
                      BoxShadow(
                        color: bg.withOpacity(0.18),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : [],
            ),
            alignment: Alignment.center,
            child: Text(
              widget.text,
              style: TextStyle(
                color: txt,
                fontWeight: widget.bold ? FontWeight.w600 : FontWeight.normal,
                fontSize: widget.fontSize,
                fontFamily: 'SF Pro Display',
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
