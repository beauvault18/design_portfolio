import 'package:flutter/material.dart';

class FadeTransitionWidget extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;
  const FadeTransitionWidget({super.key, required this.animation, required this.child});

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}
