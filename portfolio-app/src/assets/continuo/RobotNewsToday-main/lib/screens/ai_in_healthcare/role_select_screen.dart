import 'package:flutter/material.dart';
import '../../widgets/back_button.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/fade_transition_widget.dart';
import '../../utils/theme.dart';
import 'role_news_screen.dart';

class RoleSelectScreen extends StatefulWidget {
  const RoleSelectScreen({super.key});

  @override
  State<RoleSelectScreen> createState() => _RoleSelectScreenState();
}

class _RoleSelectScreenState extends State<RoleSelectScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnim;

  final List<String> roles = [
    'Nurse / Frontline Staff',
    'Provider (MD/NP/PA)',
    'Leader / Quality / Operations',
    'Tech / Innovation Partner',
    'Consumer / Family / Wellness',
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnim = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.value = 1.0;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onRoleTap(int idx) async {
    await _controller.reverse();
    await Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, anim1, anim2) =>
            RoleNewsScreen(role: roles[idx]),
        transitionsBuilder: (context, anim, _, child) =>
            FadeTransition(opacity: anim, child: child),
        transitionDuration: const Duration(milliseconds: 600),
      ),
    );
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: continuoBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
          child: Column(
            children: [
              // Top bar with back button and large centered logo
              Stack(
                children: [
                  // Back button positioned absolutely on the left
                  Positioned(
                    left: 0,
                    top: 0,
                    child: BackButtonTopBar(),
                  ),
                  // Logo centered and large
                  Container(
                    height: 150,
                    child: Center(
                      child: Image.asset(
                        'assets/logo.png',
                        width: 500,
                        height: 150,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Center(
                child: Text(
                  'Which of these best describe you?',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
              const SizedBox(height: 24), // Reduced spacing
              Expanded(
                child: FadeTransitionWidget(
                  animation: _fadeAnim,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20), // Top padding
                        ...List.generate(
                          roles.length,
                          (i) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0), // Reduced vertical padding
                            child: CustomButton(
                              text: roles[i],
                              onTap: () => _onRoleTap(i),
                              width: double.infinity,
                              height: 72,
                              backgroundColor: continuoBlue,
                              textColor: Colors.white,
                              fontSize: 22,
                              borderRadius: 12,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20), // Bottom padding
                      ],
                    ),
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
