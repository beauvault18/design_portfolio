import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'signup_manager_interface.dart';

class SignupFileManager implements SignupManagerInterface {
  static const String fileName = 'continuo_signups.json';

  /// Get the local documents directory path
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  /// Get the signup file
  Future<File> get _signupFile async {
    final path = await _localPath;
    return File('$path/$fileName');
  }

  @override
  Future<void> saveSignup({
    required String name,
    required String email,
    required String organization,
    required String title,
    required String role,
    required String interests,
  }) async {
    try {
      final file = await _signupFile;
      
      // Get existing signups
      List<Map<String, dynamic>> signups = [];
      if (await file.exists()) {
        final contents = await file.readAsString();
        if (contents.isNotEmpty) {
          final decoded = json.decode(contents) as List<dynamic>;
          signups = decoded.cast<Map<String, dynamic>>();
        }
      }
      
      // Add new signup
      signups.add({
        'name': name,
        'email': email,
        'organization': organization,
        'title': title,
        'role': role,
        'interests': interests,
        'timestamp': DateTime.now().toIso8601String(),
      });
      
      // Save back to file
      await file.writeAsString(json.encode(signups));
    } catch (e) {
      print('Error saving signup: $e');
      rethrow;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getSignups() async {
    try {
      final file = await _signupFile;
      if (await file.exists()) {
        final contents = await file.readAsString();
        if (contents.isNotEmpty) {
          final decoded = json.decode(contents) as List<dynamic>;
          return decoded.cast<Map<String, dynamic>>();
        }
      }
      return [];
    } catch (e) {
      print('Error getting signups: $e');
      return [];
    }
  }

  @override
  Future<Map<String, dynamic>> getSignupStats() async {
    final allSignups = await getSignups();
    final today = DateTime.now();
    final startOfDay = DateTime(today.year, today.month, today.day);
    
    final todaySignups = allSignups.where((signup) {
      final timestamp = DateTime.parse(signup['timestamp']);
      return timestamp.isAfter(startOfDay);
    }).toList();
    
    return {
      'total': allSignups.length,
      'today': todaySignups.length,
      'thisWeek': _getThisWeekSignups(allSignups).length,
      'thisMonth': _getThisMonthSignups(allSignups).length,
    };
  }

  @override
  Future<void> exportSignups() async {
    try {
      final signups = await getSignups();
      final path = await _localPath;
      final exportFile = File('$path/continuo_signups_export_${DateTime.now().millisecondsSinceEpoch}.txt');
      
      final buffer = StringBuffer();
      buffer.writeln('Continuo App Signups Export');
      buffer.writeln('Generated: ${DateTime.now()}');
      buffer.writeln('Total Signups: ${signups.length}');
      buffer.writeln();
      
      for (var i = 0; i < signups.length; i++) {
        final signup = signups[i];
        buffer.writeln('Signup ${i + 1}:');
        buffer.writeln('  Name: ${signup['name']}');
        buffer.writeln('  Email: ${signup['email']}');
        buffer.writeln('  Organization: ${signup['organization']}');
        buffer.writeln('  Title: ${signup['title']}');
        buffer.writeln('  Role: ${signup['role']}');
        buffer.writeln('  Interests: ${signup['interests']}');
        buffer.writeln('  Timestamp: ${signup['timestamp']}');
        buffer.writeln();
      }
      
      await exportFile.writeAsString(buffer.toString());
      print('Signups exported to: ${exportFile.path}');
    } catch (e) {
      print('Error exporting signups: $e');
    }
  }

  @override
  Future<void> exportSignupsAsCSV() async {
    try {
      final signups = await getSignups();
      final path = await _localPath;
      final exportFile = File('$path/continuo_signups_${DateTime.now().millisecondsSinceEpoch}.csv');
      
      final buffer = StringBuffer();
      // CSV Header
      buffer.writeln('Name,Email,Organization,Title,Role,Interests,Timestamp');
      
      // CSV Data
      for (final signup in signups) {
        final row = [
          _escapeCsvField(signup['name']),
          _escapeCsvField(signup['email']),
          _escapeCsvField(signup['organization']),
          _escapeCsvField(signup['title']),
          _escapeCsvField(signup['role']),
          _escapeCsvField(signup['interests']),
          _escapeCsvField(signup['timestamp']),
        ].join(',');
        buffer.writeln(row);
      }
      
      await exportFile.writeAsString(buffer.toString());
      print('Signups exported to CSV: ${exportFile.path}');
    } catch (e) {
      print('Error exporting CSV: $e');
    }
  }

  @override
  Future<void> clearSignups() async {
    try {
      final file = await _signupFile;
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      print('Error clearing signups: $e');
    }
  }

  @override
  Future<String> getTotalSignupsText() async {
    final stats = await getSignupStats();
    return 'Total Signups: ${stats['total']} (Today: ${stats['today']})';
  }

  List<Map<String, dynamic>> _getThisWeekSignups(List<Map<String, dynamic>> signups) {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final startOfWeekDay = DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day);
    
    return signups.where((signup) {
      final timestamp = DateTime.parse(signup['timestamp']);
      return timestamp.isAfter(startOfWeekDay);
    }).toList();
  }

  List<Map<String, dynamic>> _getThisMonthSignups(List<Map<String, dynamic>> signups) {
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);
    
    return signups.where((signup) {
      final timestamp = DateTime.parse(signup['timestamp']);
      return timestamp.isAfter(startOfMonth);
    }).toList();
  }

  String _escapeCsvField(String field) {
    if (field.contains(',') || field.contains('"') || field.contains('\n')) {
      return '"${field.replaceAll('"', '""')}"';
    }
    return field;
  }
}