import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'signup_manager_interface.dart';

class SignupFileManager implements SignupManagerInterface {
  static const String fileName = 'continuo_signups.txt';

  /// Get the local documents directory path
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  /// Get the signup file
  static Future<File> get _signupFile async {
    final path = await _localPath;
    return File('$path/$fileName');
  }

  /// Save a new signup entry to the text file (append mode)
  static Future<bool> saveSignup(
      String firstName, String lastName, String email) async {
    try {
      final file = await _signupFile;
      final timestamp = DateTime.now().toIso8601String();

      // Create signup entry with timestamp
      final signupEntry = {
        'timestamp': timestamp,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
      };

      // Convert to JSON string for easy parsing later
      final jsonLine = json.encode(signupEntry);

      // Append to file (create if doesn't exist)
      await file.writeAsString('$jsonLine\n', mode: FileMode.append);

      return true;
    } catch (e) {
      print('Error saving signup: $e');
      return false;
    }
  }

  /// Read all signups from the file
  static Future<List<Map<String, dynamic>>> getAllSignups() async {
    try {
      final file = await _signupFile;

      if (!await file.exists()) {
        return [];
      }

      final contents = await file.readAsString();
      final lines = contents.split('\n').where((line) => line.isNotEmpty);

      return lines
          .map((line) {
            try {
              return Map<String, dynamic>.from(json.decode(line));
            } catch (e) {
              print('Error parsing line: $line, Error: $e');
              return <String, dynamic>{};
            }
          })
          .where((map) => map.isNotEmpty)
          .toList();
    } catch (e) {
      print('Error reading signups: $e');
      return [];
    }
  }

  /// Get signups for today only
  static Future<List<Map<String, dynamic>>> getTodaySignups() async {
    final allSignups = await getAllSignups();
    final today = DateTime.now();

    return allSignups.where((signup) {
      try {
        final signupDate = DateTime.parse(signup['timestamp']);
        return signupDate.year == today.year &&
            signupDate.month == today.month &&
            signupDate.day == today.day;
      } catch (e) {
        return false;
      }
    }).toList();
  }

  /// Export signups to a formatted text file for easy reading
  static Future<String> exportToReadableFormat() async {
    try {
      final allSignups = await getAllSignups();

      if (allSignups.isEmpty) {
        return 'No signups found.';
      }

      final buffer = StringBuffer();
      buffer.writeln('Continuo App Signups Export');
      buffer.writeln('Generated: ${DateTime.now().toString()}');
      buffer.writeln('Total Signups: ${allSignups.length}');
      buffer.writeln('=' * 50);
      buffer.writeln();

      for (int i = 0; i < allSignups.length; i++) {
        final signup = allSignups[i];
        final timestamp = DateTime.parse(signup['timestamp']);

        buffer.writeln('Entry #${i + 1}');
        buffer.writeln('Date: ${timestamp.toLocal().toString().split('.')[0]}');
        buffer.writeln('Name: ${signup['firstName']} ${signup['lastName']}');
        buffer.writeln('Email: ${signup['email']}');
        buffer.writeln('-' * 30);
      }

      // Save formatted export
      final path = await _localPath;
      final exportFile = File('$path/continuo_signups_export.txt');
      await exportFile.writeAsString(buffer.toString());

      return exportFile.path;
    } catch (e) {
      print('Error exporting signups: $e');
      return 'Error exporting data';
    }
  }

  /// Get the file path for external access
  static Future<String> getSignupFilePath() async {
    final file = await _signupFile;
    return file.path;
  }

  /// Get signup statistics
  static Future<Map<String, dynamic>> getSignupStats() async {
    final allSignups = await getAllSignups();
    final todaySignups = await getTodaySignups();

    return {
      'total': allSignups.length,
      'today': todaySignups.length,
      'filePath': await getSignupFilePath(),
    };
  }
}
