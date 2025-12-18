import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../widgets/fade_transition_widget.dart';
import '../widgets/back_button.dart';
import '../utils/theme.dart';
import 'ai_in_healthcare/role_select_screen.dart';
import 'continuo_in_action/feature_gallery.dart';
import 'admin/admin_pin_screen.dart';
import 'contact/contact_screen.dart';

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({super.key});

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnim;
  bool _showButtons = true;
  bool _navigating = false;

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

  void _onButtonTap(Future<void> Function() nav) async {
    if (_navigating) return;
    setState(() => _navigating = true);
    await _controller.reverse();
    setState(() => _showButtons = false);
    await Future.delayed(const Duration(milliseconds: 100));
    await nav();
    setState(() => _navigating = false);
    _controller.forward();
    setState(() => _showButtons = true);
  }

  void _onAdminAccess() async {
    if (_navigating) return;
    setState(() => _navigating = true);
    await _controller.reverse();
    setState(() => _showButtons = false);
    await Future.delayed(const Duration(milliseconds: 100));
    await Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, anim1, anim2) => const AdminPinScreen(),
        transitionsBuilder: (context, anim, _, child) =>
            FadeTransition(opacity: anim, child: child),
        transitionDuration: const Duration(milliseconds: 600),
      ),
    );
    setState(() => _navigating = false);
    _controller.forward();
    setState(() => _showButtons = true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: continuoBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Top bar with back button and centered large logo
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
                      child: GestureDetector(
                        onLongPress: _onAdminAccess,
                        child: Image.asset(
                          'assets/logo.png',
                          width: 500,
                          height: 150,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 64),
              Expanded(
                child: Center(
                  child: FadeTransitionWidget(
                    animation: _fadeAnim,
                    child: _showButtons
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomButton(
                                text: 'Cutting-Edge AI in Healthcare',
                                onTap: () => _onButtonTap(() async {
                                  await Navigator.of(context).push(
                                    PageRouteBuilder(
                                      pageBuilder: (context, anim1, anim2) =>
                                          const RoleSelectScreen(),
                                      transitionsBuilder:
                                          (context, anim, _, child) =>
                                              FadeTransition(
                                                  opacity: anim, child: child),
                                      transitionDuration:
                                          const Duration(milliseconds: 600),
                                    ),
                                  );
                                }),
                                width: 420,
                                height: 72,
                                backgroundColor: continuoBlue,
                                textColor: Colors.white,
                                fontSize: 24,
                                borderRadius: 12,
                                margin: const EdgeInsets.only(bottom: 32),
                              ),
                              CustomButton(
                                text: 'Continuo in Action',
                                onTap: () => _onButtonTap(() async {
                                  await Navigator.of(context).push(
                                    PageRouteBuilder(
                                      pageBuilder: (context, anim1, anim2) =>
                                          const FeatureGalleryScreen(),
                                      transitionsBuilder:
                                          (context, anim, _, child) =>
                                              FadeTransition(
                                                  opacity: anim, child: child),
                                      transitionDuration:
                                          const Duration(milliseconds: 600),
                                    ),
                                  );
                                }),
                                width: 420,
                                height: 72,
                                backgroundColor: continuoBlue,
                                textColor: Colors.white,
                                fontSize: 24,
                                borderRadius: 12,
                                margin: const EdgeInsets.only(bottom: 32),
                              ),
                              CustomButton(
                                text: 'Learn More',
                                onTap: () => _onButtonTap(() async {
                                  await Navigator.of(context).push(
                                    PageRouteBuilder(
                                      pageBuilder: (context, anim1, anim2) =>
                                          const ContactScreen(),
                                      transitionsBuilder:
                                          (context, anim, _, child) =>
                                              FadeTransition(
                                                  opacity: anim, child: child),
                                      transitionDuration:
                                          const Duration(milliseconds: 600),
                                    ),
                                  );
                                }),
                                width: 420,
                                height: 72,
                                backgroundColor: continuoBlue,
                                textColor: Colors.white,
                                fontSize: 24,
                                borderRadius: 12,
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),
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
