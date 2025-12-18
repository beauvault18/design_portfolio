import 'package:flutter/material.dart';
import '../../widgets/back_button.dart';
import '../../widgets/fade_transition_widget.dart';
import '../../utils/theme.dart';
import 'video_modal.dart';
import '../contact/contact_screen.dart';

class FeatureGalleryScreen extends StatefulWidget {
  const FeatureGalleryScreen({super.key});

  @override
  State<FeatureGalleryScreen> createState() => _FeatureGalleryScreenState();
}

class _FeatureGalleryScreenState extends State<FeatureGalleryScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnim;

  final List<Map<String, String>> features = [
    {
      'title': 'Transcription Intelligence',
      'desc':
          'Automate the documentation of patient encounters through natural conversation, not commands. Experience how this transforms clinical workflow and saves valuable time.',
      'videoDesc':
          'A clinician logs in to Continuo. With one tap, voice capture begins. As they speak, Continuo transcribes in real time — accurate, structured, and ready for review. Key points are automatically organized into a SOAP note: subjective, objective, assessment, and plan. What once took minutes of typing now happens instantly — giving time back to care and reducing cognitive load.',
      'thumbnail': 'assets/images/feature1.png',
      'video': 'assets/videos/transcription_intelligence.mov',
    },
    {
      'title': 'Bluetooth Vitals Capture',
      'desc':
          'Watch vitals automatically sync from devices to patient records without any clicks or manual entry.',
      'videoDesc':
          'Continuo connects seamlessly with Bluetooth-enabled devices. Blood pressure, heart rate, and oxygen saturation appear automatically — verified and time-stamped. Abnormal values trigger a gentle on-screen alert, and the data is saved to the patient record without a single click. Accurate vitals, captured and synced — effortlessly.',
      'thumbnail': 'assets/images/feature2.png',
      'video': 'assets/videos/bluetooth_vitals_capture.mov',
    },
    {
      'title': 'Voice Entered Vitals',
      'desc':
          'No device nearby? Simply speak the vitals and watch them automatically populate the patient record.',
      'videoDesc':
          'Not near a device? Just say it. \'Blood pressure one-eighteen over eighty-two, pulse seventy-six, oxygen ninety-eight percent.\' Continuo recognizes each value, confirms accuracy, and records them instantly. The nurse reviews and approves — no manual typing, no double entry. Voice-entered vitals made simple.',
      'thumbnail': 'assets/images/feature3.png',
      'video': 'assets/videos/voice_entered_vitals.mov',
    },
    {
      'title': 'Review and Approve Billing Codes',
      'desc':
          'See how billing codes are automatically suggested and approved with transparency to reduce errors and underbilling.',
      'videoDesc':
          'After documentation is complete, Continuo automatically suggests the appropriate billing codes. The clinician reviews supporting details, adjusts if needed, and approves with a single tap. Transparency and accuracy are built in — reducing errors and underbilling. Smart coding, done in seconds.',
      'thumbnail': 'assets/images/feature4.png',
      'video': 'assets/videos/billing_code_review.mov',
    },
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnim = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.value = 1.0;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onFeatureTap(int idx) async {
    await _controller.reverse();
    final feature = features[idx]; // Use features directly instead of filteredFeatures
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => VideoModal(
        videoPath: feature['video']!,
        title: feature['title'],
        description: feature['videoDesc'] ?? feature['desc'],
        onClose: () {
          Navigator.of(context).pop();
          _controller.forward();
        },
      ),
    );
  }

  void _onContactTap() async {
    await Navigator.of(context).push(
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
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
          child: Column(
            children: [
                  // Top bar with back button, logo, and contact button
                  Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: BackButtonTopBar(),
                      ),
                      Container(
                        height: 80,
                        child: Center(
                          child: Image.asset(
                            'assets/logo.png',
                            width: 220,
                            height: 80,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      // Learn More button in top right
                      Positioned(
                        top: 0,
                        right: 0,
                        child: ElevatedButton.icon(
                          onPressed: _onContactTap,
                          icon: const Icon(Icons.contact_mail, size: 18),
                          label: const Text('Learn More'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0072CE),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 2,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Center(
                    child: Text(
                      'Which Feature Do You Want to See',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 28),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      'Transform voice into structured clinical documentation instantly',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.grey[600],
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
              Expanded(
                child: FadeTransitionWidget(
                  animation: _fadeAnim,
                  child: GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1.4, // Increased from 1.2 to make cards more compact
                            crossAxisSpacing: 20, // Reduced from 24 to 20
                            mainAxisSpacing: 20, // Reduced from 24 to 20
                          ),
                          itemCount: 4, // Always show all 4 features
                          itemBuilder: (context, index) {
                            final feature = features[index];
                            return GestureDetector(
                              onTap: () => _onFeatureTap(index),
                              child: Container(
                                padding: const EdgeInsets.all(16), // Reduced from 20 to 16
                                decoration: BoxDecoration(
                                  color: continuoAccent,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.08),
                                      blurRadius: 12,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    // Thumbnail
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          image: DecorationImage(
                                            image: AssetImage(feature['thumbnail']!),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 12), // Reduced from 16 to 12
                                    // Title and description
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            feature['title']!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium // Changed from titleLarge to titleMedium
                                                ?.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: const Color(0xFF0072CE),
                                                ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 6), // Reduced from 8 to 6
                                          Expanded(
                                            child: Text(
                                              feature['desc']!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
                                                    color: Colors.grey[700],
                                                    fontSize: 15,
                                                  ),
                                              maxLines: 4,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          const SizedBox(height: 6), // Reduced from 8 to 6
                                          // Play button indicator
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Container(
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                color: const Color(0xFF0072CE),
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              child: const Icon(
                                                Icons.play_arrow,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
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
