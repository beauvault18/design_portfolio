import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'utils/theme.dart';
import 'utils/hive_database.dart';
import 'screens/ai_in_healthcare/carousel_screen.dart';
import 'utils/inactivity_timer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await HiveDatabase.init();
  // Lock orientation to landscape only
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(const ContinuoApp());
}

class ContinuoApp extends StatefulWidget {
  const ContinuoApp({super.key});

  @override
  State<ContinuoApp> createState() => _ContinuoAppState();
}

class _ContinuoAppState extends State<ContinuoApp> {
  final GlobalKey<NavigatorState> _navKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    InactivityTimer().start(_handleTimeout);
  }

  void _handleTimeout() {
    // Fade to carousel screen after inactivity
    if (_navKey.currentState != null) {
      _navKey.currentState!.pushAndRemoveUntil(
        PageRouteBuilder(
          pageBuilder: (context, anim1, anim2) => const CarouselScreen(),
          transitionsBuilder: (context, anim, _, child) =>
              FadeTransition(opacity: anim, child: child),
          transitionDuration: const Duration(milliseconds: 700),
        ),
        (route) => false,
      );
    }
  }

  void _onUserActivity() {
    InactivityTimer().userActivity();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: _onUserActivity,
      onPanDown: (_) => _onUserActivity(),
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          _onUserActivity();
          return false;
        },
        child: MaterialApp(
          navigatorKey: _navKey,
          title: 'Continuo',
          debugShowCheckedModeBanner: false,
          theme: continuoTheme,
          home: const CarouselScreen(),
        ),
      ),
    );
  }
}
