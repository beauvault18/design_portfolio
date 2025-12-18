import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

class ContactDataManager {
  static const String _fileName = 'contact_submissions.json';
  
  /// Save contact data to persistent storage
  static Future<void> saveContactData(Map<String, dynamic> contactData) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$_fileName');
      
      List<Map<String, dynamic>> existingData = [];
      
      // Read existing data if file exists
      if (await file.exists()) {
        final contents = await file.readAsString();
        if (contents.isNotEmpty) {
          final jsonData = json.decode(contents);
          if (jsonData is List) {
            existingData = List<Map<String, dynamic>>.from(jsonData);
          }
        }
      }
      
      // Add new contact data
      existingData.add(contactData);
      
      // Write back to file
      await file.writeAsString(json.encode(existingData));
      
      print('Contact data saved successfully to: ${file.path}');
    } catch (e) {
      print('Error saving contact data: $e');
      rethrow;
    }
  }
  
  /// Retrieve all contact submissions
  static Future<List<Map<String, dynamic>>> getAllContactData() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$_fileName');
      
      if (await file.exists()) {
        final contents = await file.readAsString();
        if (contents.isNotEmpty) {
          final jsonData = json.decode(contents);
          if (jsonData is List) {
            return List<Map<String, dynamic>>.from(jsonData);
          }
        }
      }
      
      return [];
    } catch (e) {
      print('Error reading contact data: $e');
      return [];
    }
  }
  
  /// Export contact data to Downloads folder (for admin access)
  static Future<String?> exportToDownloads() async {
    try {
      final contactData = await getAllContactData();
      if (contactData.isEmpty) {
        return null;
      }
      
      // Get Downloads directory
      Directory? downloadsDir;
      if (Platform.isAndroid) {
        downloadsDir = Directory('/storage/emulated/0/Download');
      } else if (Platform.isIOS) {
        // On iOS, use Documents directory as Downloads isn't accessible
        downloadsDir = await getApplicationDocumentsDirectory();
      } else {
        // For other platforms, use Downloads directory
        final homeDir = Platform.environment['HOME'] ?? Platform.environment['USERPROFILE'];
        if (homeDir != null) {
          downloadsDir = Directory('$homeDir/Downloads');
        }
      }
      
      if (downloadsDir == null || !await downloadsDir.exists()) {
        // Fallback to application documents directory
        downloadsDir = await getApplicationDocumentsDirectory();
      }
      
      final timestamp = DateTime.now().toIso8601String().replaceAll(':', '-');
      final exportFile = File('${downloadsDir.path}/continuo_contacts_$timestamp.json');
      
      // Create formatted JSON with pretty printing
      const encoder = JsonEncoder.withIndent('  ');
      final prettyJson = encoder.convert(contactData);
      
      await exportFile.writeAsString(prettyJson);
      
      print('Contact data exported to: ${exportFile.path}');
      return exportFile.path;
    } catch (e) {
      print('Error exporting contact data: $e');
      rethrow;
    }
  }
  
  /// Get count of contact submissions
  static Future<int> getContactCount() async {
    final data = await getAllContactData();
    return data.length;
  }
  
  /// Clear all contact data (for admin use)
  static Future<void> clearAllContactData() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$_fileName');
      
      if (await file.exists()) {
        await file.delete();
      }
      
      print('Contact data cleared');
    } catch (e) {
      print('Error clearing contact data: $e');
      rethrow;
    }
  }
}