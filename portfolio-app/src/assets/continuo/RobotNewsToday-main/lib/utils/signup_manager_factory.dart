import 'package:flutter/foundation.dart';
import 'signup_manager_interface.dart';
import 'signup_file_manager.dart';

// Use conditional imports - web version only on web, stub on mobile
import 'web_signup_manager.dart'
    if (dart.library.io) 'web_signup_manager_stub.dart';

class SignupManagerFactory {
  static SignupManagerInterface createManager() {
    if (kIsWeb) {
      return WebSignupManager();
    } else {
      return SignupFileManager();
    }
  }
}
