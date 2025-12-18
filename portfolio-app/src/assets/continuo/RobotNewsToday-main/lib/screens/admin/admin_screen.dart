import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import '../../widgets/continuo_logo.dart';
import '../../widgets/back_button.dart';
import '../../utils/theme.dart';
import '../../utils/contact_data_manager.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  List<Map<String, dynamic>> contacts = [];
  Map<String, dynamic> stats = {};
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => loading = true);

    // Get contact data count and actual contact submissions
    final contactCount = await ContactDataManager.getContactCount();
    final allContacts = await ContactDataManager.getAllContactData();

    setState(() {
      contacts = allContacts;
      stats = {
        'contactSubmissions': contactCount,
      };
      loading = false;
    });
  }

  Future<void> _exportContactData() async {
    try {
      final contactCount = await ContactDataManager.getContactCount();
      
      if (contactCount == 0) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No contact submissions to export'),
            backgroundColor: Colors.orange,
          ),
        );
        return;
      }

      final filePath = await ContactDataManager.exportToDownloads();
      
      if (!mounted) return;

      if (filePath != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Contact data exported successfully ($contactCount submissions)'),
                const SizedBox(height: 4),
                Text('File: $filePath', style: const TextStyle(fontSize: 12)),
              ],
            ),
            duration: const Duration(seconds: 6),
            backgroundColor: Colors.green,
            action: SnackBarAction(
              label: 'Copy Path',
              textColor: Colors.white,
              onPressed: () => _copyToClipboard(filePath),
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Export failed: Unable to create file'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Contact export failed: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Copied to clipboard'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  Widget _buildContactCard(Map<String, dynamic> contact, int index) {
    final timestamp = DateTime.parse(contact['timestamp']);
    final formattedDate =
        '${timestamp.day}/${timestamp.month}/${timestamp.year} ${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: continuoBlue,
          child:
              Text('${index + 1}', style: const TextStyle(color: Colors.white)),
        ),
        title: Text('${contact['name']}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (contact['email']?.isNotEmpty == true)
              Text('Email: ${contact['email']}'),
            if (contact['phone']?.isNotEmpty == true)
              Text('Phone: ${contact['phone']}'),
            Text('Date: $formattedDate',
                style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.copy),
          onPressed: () => _copyToClipboard(
              '${contact['name']},${contact['email'] ?? ''},${contact['phone'] ?? ''},$formattedDate'),
        ),
        isThreeLine: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: continuoBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
          child: Column(
            children: [
              // Top bar
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BackButtonTopBar(),
                  ContinuoLogo(size: 100),
                  SizedBox(width: 56),
                ],
              ),
              const SizedBox(height: 32),

              // Title and stats
              Text(
                'Admin Dashboard',
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(height: 16),

              if (!loading) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: continuoBlue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Total Contact Submissions: ${stats['contactSubmissions'] ?? 0}',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: continuoBlue,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Export button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: _exportContactData,
                      icon: const Icon(Icons.contact_mail),
                      label: const Text('Export Contacts'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
              ],

              // Signups list
              Expanded(
                child: loading
                    ? const Center(child: CircularProgressIndicator())
                    : contacts.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.inbox_outlined,
                                  size: 64,
                                  color: Colors.grey[400],
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'No contact submissions yet',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                        color: Colors.grey[600],
                                      ),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            itemCount: contacts.length,
                            itemBuilder: (context, index) =>
                                _buildContactCard(contacts[index], index),
                          ),
              ),

              // Storage info
              if (!loading && stats.isNotEmpty) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        kIsWeb ? Icons.web : Icons.folder_outlined,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          kIsWeb
                              ? 'Contact data stored in: Browser LocalStorage'
                              : 'Contact data saved to: Local file system',
                          style:
                              const TextStyle(fontSize: 12, color: Colors.grey),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (!kIsWeb) // Only show copy button for file paths
                        IconButton(
                          icon: const Icon(Icons.copy, size: 16),
                          onPressed: () =>
                              _copyToClipboard('Contact submissions saved locally'),
                        ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
