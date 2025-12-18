import 'package:hive/hive.dart';

class RoleManager {
  static const String roleBox = 'user_role';
  static const String defaultRole = 'All';

  // Available roles that match the existing system
  static const List<String> availableRoles = [
    'All',
    'Nurse / Frontline Staff',
    'Provider (MD/NP/PA)',
    'Leader / Quality / Operations',
    'Tech / Innovation Partner',
    'Consumer / Family / Wellness',
  ];

  // Feature to role mapping - defines which roles can see which features
  static const Map<String, List<String>> featureRoleMapping = {
    'Virtual Care': [
      'All',
      'Nurse / Frontline Staff',
      'Provider (MD/NP/PA)',
      'Consumer / Family / Wellness',
    ],
    'AI Triage': [
      'All',
      'Nurse / Frontline Staff',
      'Provider (MD/NP/PA)',
      'Leader / Quality / Operations',
    ],
    'Care Coordination': [
      'All',
      'Nurse / Frontline Staff',
      'Provider (MD/NP/PA)',
      'Leader / Quality / Operations',
    ],
    'Analytics': [
      'All',
      'Leader / Quality / Operations',
      'Tech / Innovation Partner',
    ],
  };

  static Future<void> init() async {
    await Hive.openBox(roleBox);
  }

  static Future<void> setUserRole(String role) async {
    final box = Hive.box(roleBox);
    await box.put('current_role', role);
  }

  static String getCurrentRole() {
    final box = Hive.box(roleBox);
    return box.get('current_role', defaultValue: defaultRole);
  }

  static Future<void> clearRole() async {
    final box = Hive.box(roleBox);
    await box.delete('current_role');
  }

  /// Returns the list of features that the current user role can access
  static List<Map<String, String>> getFilteredFeatures(
      List<Map<String, String>> allFeatures) {
    final currentRole = getCurrentRole();

    if (currentRole == 'All') {
      return allFeatures;
    }

    return allFeatures.where((feature) {
      final featureTitle = feature['title'] ?? '';
      final allowedRoles = featureRoleMapping[featureTitle] ?? [];
      return allowedRoles.contains(currentRole);
    }).toList();
  }

  /// Checks if a specific feature is accessible to the current role
  static bool canAccessFeature(String featureTitle) {
    final currentRole = getCurrentRole();

    if (currentRole == 'All') {
      return true;
    }

    final allowedRoles = featureRoleMapping[featureTitle] ?? [];
    return allowedRoles.contains(currentRole);
  }
}
