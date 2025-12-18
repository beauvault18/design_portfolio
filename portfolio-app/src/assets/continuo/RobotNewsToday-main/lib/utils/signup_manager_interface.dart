abstract class SignupManagerInterface {
  Future<void> saveSignup({
    required String name,
    required String email,
    required String organization,
    required String title,
    required String role,
    required String interests,
  });

  Future<List<Map<String, dynamic>>> getSignups();
  Future<Map<String, dynamic>> getSignupStats();
  Future<void> exportSignups();
  Future<void> exportSignupsAsCSV();
  Future<void> clearSignups();
  Future<String> getTotalSignupsText();
}
