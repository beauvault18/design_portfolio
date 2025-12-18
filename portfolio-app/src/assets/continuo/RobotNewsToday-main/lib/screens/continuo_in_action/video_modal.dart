import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoModal extends StatefulWidget {
  final String videoPath;
  final VoidCallback onClose;
  final String? title;
  final String? description;
  const VideoModal({
    super.key,
    required this.videoPath,
    required this.onClose,
    this.title,
    this.description,
  });

  @override
  State<VideoModal> createState() => _VideoModalState();
}

class _VideoModalState extends State<VideoModal> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;
  bool _initialized = false;
  bool _hasError = false;
  String _errorMessage = '';
  bool _isClosing = false; // Add flag to prevent multiple close calls

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  void _initializeVideo() async {
    try {
      _controller = VideoPlayerController.asset(widget.videoPath);
      await _controller.initialize();

      if (mounted) {
        setState(() {
          _initialized = true;
          _hasError = false;
        });

        // Auto-play the video when initialized
        _playVideo();
      }

      _controller.addListener(_onVideoEnd);
    } catch (e) {
      print('Error initializing video: $e');
      if (mounted) {
        setState(() {
          _hasError = true;
          _errorMessage = 'Unable to load video';
          _initialized = false;
        });
      }
    }
  }

  void _onVideoEnd() {
    // Prevent multiple close calls and ensure we're still mounted
    if (_isClosing || !mounted || _hasError || !_initialized) {
      return;
    }

    if (_controller.value.isInitialized) {
      final position = _controller.value.position;
      final duration = _controller.value.duration;

      // Check if video has finished (within 100ms of the end)
      if (position >= duration - const Duration(milliseconds: 100)) {
        _isClosing = true; // Set flag to prevent multiple calls

        // Use post-frame callback to ensure UI is ready for navigation
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted && !_hasError) {
            widget.onClose();
          }
        });
      }
    }
  }

  @override
  void dispose() {
    _isClosing = true; // Prevent any further callbacks

    if (_initialized && !_hasError) {
      try {
        _controller.removeListener(_onVideoEnd);
        _controller.dispose();
      } catch (e) {
        print('Error disposing video controller: $e');
      }
    }
    super.dispose();
  }

  void _playVideo() async {
    if (_hasError || !_initialized) return;

    try {
      setState(() => _isPlaying = true);
      await _controller.play();
    } catch (e) {
      print('Error playing video: $e');
      setState(() {
        _hasError = true;
        _errorMessage = 'Unable to play video';
        _isPlaying = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: widget.onClose,
          child: Container(
            color: Colors.black.withOpacity(0.4),
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.8,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: _hasError
                ? Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error_outline,
                            size: 64, color: Colors.red),
                        const SizedBox(height: 16),
                        Text(
                          'Video Unavailable',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _errorMessage.isNotEmpty
                              ? _errorMessage
                              : 'Unable to load video content',
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            if (!_isClosing) {
                              _isClosing = true;
                              widget.onClose();
                            }
                          },
                          child: const Text('Close'),
                        ),
                      ],
                    ),
                  )
                : _initialized
                    ? Row(
                        children: [
                          // Left side - Text panel (50% width)
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding: const EdgeInsets.all(32),
                              decoration: BoxDecoration(
                                color: Colors.grey[50],
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  bottomLeft: Radius.circular(12),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.title ?? 'Feature Demo',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xFF0072CE),
                                        ),
                                  ),
                                  const SizedBox(height: 24),
                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: Text(
                                        widget.description ??
                                            'Watch this demonstration to see how our innovative healthcare solution can transform your workflow and improve patient outcomes.',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall
                                            ?.copyWith(
                                              height: 1.6,
                                              fontSize: 24,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.play_circle_outline,
                                        color: Color(0xFF0072CE),
                                        size: 20,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        _isPlaying ? 'Playing' : 'Paused',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              color: const Color(0xFF0072CE),
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Right side - Video player (50% width)
                          Expanded(
                            flex: 1,
                            child: Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(12),
                                  bottomRight: Radius.circular(12),
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(12),
                                  bottomRight: Radius.circular(12),
                                ),
                                child: AspectRatio(
                                  aspectRatio: _controller.value.aspectRatio,
                                  child: Stack(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          // Toggle play/pause on tap
                                          if (_controller.value.isPlaying) {
                                            _controller.pause();
                                            setState(() => _isPlaying = false);
                                          } else {
                                            _playVideo();
                                          }
                                        },
                                        child: VideoPlayer(_controller),
                                      ),
                                      // Show play button only when paused
                                      if (!_isPlaying && _initialized)
                                        Center(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              shape: BoxShape.circle,
                                            ),
                                            child: IconButton(
                                              icon: const Icon(Icons.play_arrow,
                                                  size: 64,
                                                  color: Colors.white),
                                              onPressed: _playVideo,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage('assets/logo.png'),
                              width: 120,
                              height: 120,
                            ),
                            SizedBox(height: 16),
                            CircularProgressIndicator(),
                          ],
                        ),
                      ),
          ),
        ),
        // Close button positioned outside the content area
        Positioned(
          top: 50,
          right: 50,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.close, size: 32, color: Colors.white),
              onPressed: () {
                if (!_isClosing) {
                  _isClosing = true;
                  widget.onClose();
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
