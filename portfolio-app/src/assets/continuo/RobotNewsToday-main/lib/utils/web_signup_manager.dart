// This file will only be imported on web platforms
import 'dart:convert';
import 'dart:html' as html;
import 'package:flutter/foundation.dart';
import 'signup_manager_interface.dart';

class WebSignupManager implements SignupManagerInterface {
  static const String storageKey = 'continuo_signups';

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
      if (kIsWeb) {
        // Get existing signups
        final existingData = html.window.localStorage[storageKey];
        List<Map<String, dynamic>> signups = [];
        
        if (existingData != null) {
          final decoded = json.decode(existingData) as List<dynamic>;
          signups = decoded.cast<Map<String, dynamic>>();
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
        
        // Save back to localStorage
        html.window.localStorage[storageKey] = json.encode(signups);
      }
    } catch (e) {
      print('Error saving signup: $e');
      rethrow;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getSignups() async {
    try {
      if (kIsWeb) {
        final data = html.window.localStorage[storageKey];
        if (data != null) {
          final decoded = json.decode(data) as List<dynamic>;
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
      
      final blob = html.Blob([buffer.toString()], 'text/plain');
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: url);
      anchor.download = 'continuo_signups_${DateTime.now().millisecondsSinceEpoch}.txt';
      anchor.click();
      
      html.document.body?.append(anchor);
      anchor.click();
      anchor.remove();
      html.Url.revokeObjectUrl(url);
    } catch (e) {
      print('Error exporting signups: $e');
    }
  }

  @override
  Future<void> exportSignupsAsCSV() async {
    try {
      final signups = await getSignups();
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
      
      final blob = html.Blob([buffer.toString()], 'text/csv');
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: url);
      anchor.download = 'continuo_signups_${DateTime.now().millisecondsSinceEpoch}.csv';
      anchor.click();
      
      html.document.body?.append(anchor);
      anchor.click();
      anchor.remove();
      html.Url.revokeObjectUrl(url);
    } catch (e) {
      print('Error exporting CSV: $e');
    }
  }

  @override
  Future<void> clearSignups() async {
    try {
      if (kIsWeb) {
        html.window.localStorage.remove(storageKey);
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