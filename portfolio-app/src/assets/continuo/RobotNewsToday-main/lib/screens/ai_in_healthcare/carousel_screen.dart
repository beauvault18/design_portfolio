import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../widgets/fade_transition_widget.dart';
import '../../utils/theme.dart';
import '../main_menu.dart';
import '../contact/contact_screen.dart';

class CarouselScreen extends StatefulWidget {
  const CarouselScreen({super.key});

  @override
  State<CarouselScreen> createState() => _CarouselScreenState();
}

class _CarouselScreenState extends State<CarouselScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnim;
  late PageController _pageController;
  late AnimationController _rotationController;
  int _currentIndex = 0;
  List<Map<String, String>> newsStories = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnim = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.value = 1.0;

    // Initialize page controller
    _pageController = PageController(
      viewportFraction: 0.9, // Show more of adjacent cards
      initialPage: 0,
    );

    // Initialize rotation controller for auto-rotation
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4), // Rotate every 4 seconds
    );

    // Load news stories and start auto-rotation
    _loadNewsStories();
  }

  Future<void> _loadNewsStories() async {
    try {
      List<Map<String, String>> stories = [];

      for (int i = 1; i <= 7; i++) {
        try {
          final header =
              await rootBundle.loadString('assets/news/story${i}_header.txt');
          final content =
              await rootBundle.loadString('assets/news/story${i}_content.md');

          // Extract a brief description from the content
          final lines = content.split('\n');
          String description = '';
          for (String line in lines) {
            if (line.trim().isNotEmpty &&
                !line.startsWith('#') &&
                !line.startsWith('##')) {
              description = line.trim();
              if (description.length > 200) {
                description = '${description.substring(0, 200)}...';
              }
              break;
            }
          }

          // Check if image exists for this story
          String? imagePath;
          try {
            await rootBundle.load('assets/news/images/story_${i}_image.jpg');
            imagePath = 'assets/news/images/story_${i}_image.jpg';
          } catch (e) {
            // Image doesn't exist, use null
            imagePath = null;
          }

          stories.add({
            'title': header.trim(),
            'desc': description,
            'content': content,
            'image': imagePath ?? '', // Use empty string if no image
          });
        } catch (e) {
          print('Error loading story $i: $e');
        }
      }

      setState(() {
        newsStories = stories;
        _isLoading = false;
      });

      // Start auto-rotation after stories are loaded
      if (newsStories.isNotEmpty) {
        _startAutoRotation();
      }
    } catch (e) {
      print('Error loading news stories: $e');
      setState(() {
        _isLoading = false;
        // Fallback to empty list - carousel will show loading message
      });
    }
  }

  void _startAutoRotation() {
    _rotationController.addListener(() {
      if (_rotationController.status == AnimationStatus.completed) {
        _nextCard();
        _rotationController.reset();
        _rotationController.forward();
      }
    });
    _rotationController.forward();
  }

  void _nextCard() {
    if (newsStories.isNotEmpty) {
      _currentIndex = (_currentIndex + 1) % newsStories.length;
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _rotationController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _onCardTap(int idx) async {
    // Pause auto-rotation when user interacts
    _rotationController.stop();

    await _controller.reverse();
    await Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, anim1, anim2) => const MainMenuScreen(),
        transitionsBuilder: (context, anim, _, child) =>
            FadeTransition(opacity: anim, child: child),
        transitionDuration: const Duration(milliseconds: 600),
      ),
    );
    _controller.forward();

    // Resume auto-rotation when returning
    _rotationController.reset();
    _rotationController.forward();
  }

  void _onContactTap() async {
    // Pause auto-rotation when user interacts
    _rotationController.stop();

    await Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, anim1, anim2) => const ContactScreen(),
        transitionsBuilder: (context, anim, _, child) =>
            FadeTransition(opacity: anim, child: child),
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );

    // Resume auto-rotation when returning
    _rotationController.reset();
    _rotationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: continuoBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            children: [
              // Top section with logo and contact button
              Stack(
                children: [
                  // Centered logo
                  Container(
                    height: 150, // Increased height for larger logo
                    child: Center(
                      child: Image.asset(
                        'assets/logo.png',
                        width: 500, // Much larger width
                        height: 150, // Larger height
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
              const SizedBox(height: 12), // Reduced spacing
              Center(
                child: Text(
                  'AI Healthcare News',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: FadeTransitionWidget(
                  animation: _fadeAnim,
                  child: Column(
                    children: [
                      Expanded(
                        child: _isLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: continuoBlue,
                                ),
                              )
                            : newsStories.isEmpty
                                ? const Center(
                                    child: Text(
                                      'No news stories available',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  )
                                : PageView.builder(
                                    controller: _pageController,
                                    onPageChanged: (index) {
                                      setState(() {
                                        _currentIndex = index;
                                      });
                                      // Reset rotation timer when user manually changes page
                                      _rotationController.reset();
                                      _rotationController.forward();
                                    },
                                    itemCount: newsStories.length,
                                    itemBuilder: (context, i) {
                                      final story = newsStories[i];
                                      return GestureDetector(
                                        onTap: () => _onCardTap(i),
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 4),
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            color: continuoAccent,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.06),
                                                blurRadius: 12,
                                                offset: const Offset(0, 4),
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              // Image section (if available)
                                              if (story['image'] != null) ...[
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  child: Image.asset(
                                                    story['image']!,
                                                    width: 350,
                                                    height: 400,
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (context,
                                                        error, stackTrace) {
                                                      return Container(
                                                        width: 350,
                                                        height: 400,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Colors.grey[300],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        child: Icon(
                                                          Icons
                                                              .image_not_supported,
                                                          color:
                                                              Colors.grey[600],
                                                          size: 120,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                const SizedBox(width: 16),
                                              ],
                                              // Text content section
                                              Expanded(
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        story['title']!,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleLarge
                                                            ?.copyWith(
                                                              fontSize: 28,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                      const SizedBox(
                                                          height: 16),
                                                      Text(
                                                        story['content']!,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium,
                                                      ),
                                                      const SizedBox(height: 20),
                                                      // Learn More button
                                                      ElevatedButton.icon(
                                                        onPressed: _onContactTap,
                                                        icon: const Icon(Icons.contact_mail, size: 16),
                                                        label: const Text('Learn More'),
                                                        style: ElevatedButton.styleFrom(
                                                          backgroundColor: const Color(0xFF0072CE),
                                                          foregroundColor: Colors.white,
                                                          padding: const EdgeInsets.symmetric(
                                                            horizontal: 20,
                                                            vertical: 12,
                                                          ),
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(8),
                                                          ),
                                                          elevation: 2,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                      ),
                      const SizedBox(height: 16),
                      // Dot indicators
                      if (!_isLoading && newsStories.isNotEmpty)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            newsStories.length,
                            (index) => Container(
                              width: 6,
                              height: 6,
                              margin: const EdgeInsets.symmetric(horizontal: 3),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _currentIndex == index
                                    ? continuoBlue
                                    : continuoBlue.withOpacity(0.3),
                              ),
                            ),
                          ),
                        ),
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
