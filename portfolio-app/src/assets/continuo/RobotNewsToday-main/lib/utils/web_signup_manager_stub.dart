// Stub file for mobile platforms where dart:html is not available
import 'signup_manager_interface.dart';

class WebSignupManager implements SignupManagerInterface {
  @override
  Future<void> saveSignup({
    required String name,
    required String email,
    required String organization,
    required String title,
    required String role,
    required String interests,
  }) async {
    throw UnsupportedError(
        'WebSignupManager is not supported on this platform');
  }

  @override
  Future<List<Map<String, dynamic>>> getSignups() async {
    throw UnsupportedError(
        'WebSignupManager is not supported on this platform');
  }

  @override
  Future<Map<String, dynamic>> getSignupStats() async {
    throw UnsupportedError(
        'WebSignupManager is not supported on this platform');
  }

  @override
  Future<void> exportSignups() async {
    throw UnsupportedError(
        'WebSignupManager is not supported on this platform');
  }

  @override
  Future<void> exportSignupsAsCSV() async {
    throw UnsupportedError(
        'WebSignupManager is not supported on this platform');
  }

  @override
  Future<void> clearSignups() async {
    throw UnsupportedError(
        'WebSignupManager is not supported on this platform');
  }

  @override
  Future<String> getTotalSignupsText() async {
    throw UnsupportedError(
        'WebSignupManager is not supported on this platform');
  }
}
