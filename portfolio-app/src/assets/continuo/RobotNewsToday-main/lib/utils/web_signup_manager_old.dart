import 'dart:convert';
import 'dart:html' as html;
import 'package:flutter/foundation.dart';
import 'signup_manager_interface.dart';

class WebSignupManager implements SignupManagerInterface {
  static const String storageKey = 'continuo_signups';

  /// Save a new signup entry to localStorage (web) or return false for other platforms
  static Future<bool> saveSignup(
      String firstName, String lastName, String email) async {
    try {
      if (kIsWeb) {
        final timestamp = DateTime.now().toIso8601String();

        // Create signup entry with timestamp
        final signupEntry = {
          'timestamp': timestamp,
          'firstName': firstName,
          'lastName': lastName,
          'email': email,
        };

        // Get existing signups from localStorage
        final existingData = html.window.localStorage[storageKey];
        List<Map<String, dynamic>> signups = [];

        if (existingData != null && existingData.isNotEmpty) {
          try {
            final decoded = json.decode(existingData);
            signups = List<Map<String, dynamic>>.from(decoded);
          } catch (e) {
            print('Error parsing existing signups: $e');
            // Start fresh if data is corrupted
            signups = [];
          }
        }

        // Add new signup
        signups.add(signupEntry);

        // Save back to localStorage
        html.window.localStorage[storageKey] = json.encode(signups);

        return true;
      } else {
        print('WebSignupManager only works on web platform');
        return false;
      }
    } catch (e) {
      print('Error saving signup: $e');
      return false;
    }
  }

  /// Read all signups from localStorage
  static Future<List<Map<String, dynamic>>> getAllSignups() async {
    try {
      if (kIsWeb) {
        final data = html.window.localStorage[storageKey];

        if (data == null || data.isEmpty) {
          return [];
        }

        final decoded = json.decode(data);
        return List<Map<String, dynamic>>.from(decoded);
      } else {
        return [];
      }
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

  /// Download signups as a text file
  static Future<String> downloadSignupsFile() async {
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

      // Create and download file
      if (kIsWeb) {
        final blob = html.Blob([buffer.toString()], 'text/plain');
        final url = html.Url.createObjectUrlFromBlob(blob);
        final anchor = html.AnchorElement(href: url);
        anchor.target = 'blank';
        anchor.download =
            'continuo_signups_${DateTime.now().millisecondsSinceEpoch}.txt';
        html.document.body?.append(anchor);
        anchor.click();
        anchor.remove();
        html.Url.revokeObjectUrl(url);

        return 'File downloaded successfully!';
      }

      return 'Download not supported on this platform';
    } catch (e) {
      print('Error downloading signups: $e');
      return 'Error downloading data: $e';
    }
  }

  /// Download signups as CSV file
  static Future<String> downloadSignupsCSV() async {
    try {
      final allSignups = await getAllSignups();

      if (allSignups.isEmpty) {
        return 'No signups found.';
      }

      final buffer = StringBuffer();
      // CSV Header
      buffer.writeln('Timestamp,First Name,Last Name,Email,Date,Time');

      for (final signup in allSignups) {
        final timestamp = DateTime.parse(signup['timestamp']);
        final date = '${timestamp.day}/${timestamp.month}/${timestamp.year}';
        final time =
            '${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';

        buffer.writeln(
            '${signup['timestamp']},${signup['firstName']},${signup['lastName']},${signup['email']},$date,$time');
      }

      // Create and download CSV file
      if (kIsWeb) {
        final blob = html.Blob([buffer.toString()], 'text/csv');
        final url = html.Url.createObjectUrlFromBlob(blob);
        final anchor = html.AnchorElement(href: url);
        anchor.target = 'blank';
        anchor.download =
            'continuo_signups_${DateTime.now().millisecondsSinceEpoch}.csv';
        html.document.body?.append(anchor);
        anchor.click();
        anchor.remove();
        html.Url.revokeObjectUrl(url);

        return 'CSV file downloaded successfully!';
      }

      return 'Download not supported on this platform';
    } catch (e) {
      print('Error downloading CSV: $e');
      return 'Error downloading CSV: $e';
    }
  }

  /// Clear all signups (for testing or admin use)
  static Future<bool> clearAllSignups() async {
    try {
      if (kIsWeb) {
        html.window.localStorage.remove(storageKey);
        return true;
      }
      return false;
    } catch (e) {
      print('Error clearing signups: $e');
      return false;
    }
  }

  /// Get signup statistics
  static Future<Map<String, dynamic>> getSignupStats() async {
    final allSignups = await getAllSignups();
    final todaySignups = await getTodaySignups();

    return {
      'total': allSignups.length,
      'today': todaySignups.length,
      'storageType': 'LocalStorage (Web)',
    };
  }
}
