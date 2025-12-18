import 'package:flutter/material.dart';
import '../../widgets/continuo_logo.dart';
import '../../widgets/back_button.dart';
import '../../widgets/fade_transition_widget.dart';
import '../../utils/theme.dart';
import 'video_modal.dart';

class VideoLibraryScreen extends StatefulWidget {
  final String? filter;
  const VideoLibraryScreen({super.key, this.filter});

  @override
  State<VideoLibraryScreen> createState() => _VideoLibraryScreenState();
}

class _VideoLibraryScreenState extends State<VideoLibraryScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnim;
  late ScrollController _scrollController;

  final List<Map<String, String>> videos = [
    {
      'title': 'Virtual Care',
      'desc':
          'Seamless telehealth and remote monitoring solutions that enable healthcare providers to deliver exceptional care regardless of location. Our platform integrates video consultations, remote patient monitoring, and digital health tools to create a comprehensive virtual care experience that improves patient access while maintaining the highest standards of medical care.',
      'thumbnail': 'assets/images/feature1.png',
      'video': 'assets/videos/virtual_care.mov',
    },
    {
      'title': 'AI Triage',
      'desc':
          'Intelligent patient routing and prioritization powered by advanced artificial intelligence algorithms. This system analyzes patient symptoms, medical history, and urgency factors to automatically direct patients to the most appropriate care setting and provider, reducing wait times and ensuring critical cases receive immediate attention.',
      'thumbnail': 'assets/images/feature2.png',
      'video': 'assets/videos/ai_triage.mov',
    },
    {
      'title': 'Care Coordination',
      'desc':
          'Streamlined communication and coordination tools that connect care teams across departments and facilities. Our platform facilitates seamless information sharing, care plan collaboration, and real-time updates to ensure all team members are aligned in delivering coordinated, patient-centered care.',
      'thumbnail': 'assets/images/feature3.png',
      'video': 'assets/videos/care_coordination.mov',
    },
    {
      'title': 'Analytics',
      'desc':
          'Real-time insights and performance metrics that transform healthcare data into actionable intelligence. Our comprehensive analytics dashboard provides healthcare leaders with the visibility needed to optimize operations, improve patient outcomes, and make data-driven decisions that enhance overall organizational performance.',
      'thumbnail': 'assets/images/feature4.png',
      'video': 'assets/videos/analytics.mov',
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
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onVideoTap(int idx, List<Map<String, String>> videos) async {
    await _controller.reverse();
    final video = videos[idx];
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => VideoModal(
        videoPath: video['video']!,
        title: video['title'],
        description: video['desc'],
        onClose: () {
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          }
        },
      ),
    );
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final filter = widget.filter;
    final filteredVideos = filter == null || filter == 'All'
        ? videos
        : videos.where((v) => v['category'] == filter).toList();
    return Scaffold(
      backgroundColor: continuoBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BackButtonTopBar(),
                  ContinuoLogo(size: 100),
                  SizedBox(width: 56),
                ],
              ),
              const SizedBox(height: 32),
              Center(
                child: Text(
                  filter == null || filter == 'All'
                      ? 'Feature Library'
                      : 'Showing: $filter',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: FadeTransitionWidget(
                  animation: _fadeAnim,
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: filteredVideos.length,
                    itemBuilder: (context, i) {
                      final video = filteredVideos[i];
                      return GestureDetector(
                        onTap: () => _onVideoTap(i, videos),
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 16),
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
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  video['thumbnail']!,
                                  width: 120,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 32),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      video['title']!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge
                                          ?.copyWith(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      video['desc']!,
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
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
