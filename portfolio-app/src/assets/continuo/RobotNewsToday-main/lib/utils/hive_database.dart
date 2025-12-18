import 'package:hive/hive.dart';
import 'role_manager.dart';

class HiveDatabase {
  static const String signupBox = 'signups';

  static Future<void> init() async {
    await Hive.openBox(signupBox);
    await RoleManager.init();
  }

  static Future<void> saveSignup(
      String first, String last, String email) async {
    final box = Hive.box(signupBox);
    await box.add({'firstName': first, 'lastName': last, 'email': email});
  }

  static List<Map> getAllSignups() {
    final box = Hive.box(signupBox);
    return box.values.cast<Map>().toList();
  }
}
