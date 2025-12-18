import 'package:flutter/material.dart';
import '../../widgets/back_button.dart';
import '../../utils/theme.dart';
import '../contact/contact_screen.dart';

class NewsStoryDetailScreen extends StatelessWidget {
  final String title;
  final String content;
  final String? imagePath;

  const NewsStoryDetailScreen({
    super.key,
    required this.title,
    required this.content,
    this.imagePath,
  });

  void _onContactTap(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, anim1, anim2) => const ContactScreen(),
        transitionsBuilder: (context, anim, _, child) =>
            FadeTransition(opacity: anim, child: child),
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: continuoBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
          child: Column(
            children: [
              // Very compact header with back button, tiny logo, and contact button
              Stack(
                children: [
                  // Back button positioned absolutely
                  Positioned(
                    left: 0,
                    top: 0,
                    child: BackButtonTopBar(),
                  ),
                  // Much smaller logo centered
                  Container(
                    height: 50,
                    child: Center(
                      child: Image.asset(
                        'assets/logo.png',
                        width: 180,
                        height: 50,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  // Learn More button in top right
                  Positioned(
                    top: 4,
                    right: 0,
                    child: ElevatedButton.icon(
                      onPressed: () => _onContactTap(context),
                      icon: const Icon(Icons.contact_mail, size: 14),
                      label: const Text('Learn More', style: TextStyle(fontSize: 12)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0072CE),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        elevation: 2,
                        minimumSize: Size.zero,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        title,
                        style:
                            Theme.of(context).textTheme.displayLarge?.copyWith(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      const SizedBox(height: 24),

                      // Image if available
                      if (imagePath != null && imagePath!.isNotEmpty) ...[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            imagePath!,
                            width: double.infinity,
                            height: 300,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: double.infinity,
                                height: 300,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  Icons.image_not_supported,
                                  color: Colors.grey[600],
                                  size: 80,
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],

                      // Content
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: continuoAccent,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.06),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Text(
                          content,
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    height: 1.6,
                                    fontSize: 16,
                                  ),
                        ),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
