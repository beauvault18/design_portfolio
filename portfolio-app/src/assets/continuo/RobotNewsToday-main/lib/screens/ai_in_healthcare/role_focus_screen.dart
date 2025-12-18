import 'package:flutter/material.dart';
import '../../widgets/continuo_logo.dart';
import '../../widgets/back_button.dart';
import '../../widgets/fade_transition_widget.dart';
import '../../widgets/custom_button.dart';
import '../../utils/theme.dart';
import 'info_modal.dart';
import 'signup_modal.dart';

class RoleFocusScreen extends StatefulWidget {
  final String role;
  const RoleFocusScreen({super.key, required this.role});

  @override
  State<RoleFocusScreen> createState() => _RoleFocusScreenState();
}

class _RoleFocusScreenState extends State<RoleFocusScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnim;

  // Example topics for each role (replace with real content as needed)
  final Map<String, List<Map<String, String>>> roleTopics = {
    'Nurse / Frontline Staff': [
      {'title': 'Smart Rounding', 'desc': 'AI-powered patient prioritization.'},
      {
        'title': 'Real-Time Alerts',
        'desc': 'Instant notifications for critical changes.'
      },
      {'title': 'Workflow Automation', 'desc': 'Reduce manual charting.'},
      {'title': 'Care Team Chat', 'desc': 'Secure, AI-assisted communication.'},
    ],
    'Provider (MD/NP/PA)': [
      {
        'title': 'Clinical Decision Support',
        'desc': 'Evidence-based AI recommendations.'
      },
      {
        'title': 'Predictive Analytics',
        'desc': 'Risk scoring and early warnings.'
      },
      {'title': 'Documentation Assist', 'desc': 'Faster, smarter charting.'},
      {
        'title': 'Patient Engagement',
        'desc': 'AI-driven follow-up and education.'
      },
    ],
    'Leader / Quality / Operations': [
      {'title': 'Quality Dashboards', 'desc': 'Live metrics and trends.'},
      {
        'title': 'Resource Optimization',
        'desc': 'AI for staffing and supply chain.'
      },
      {'title': 'Compliance Tracking', 'desc': 'Automated audit trails.'},
      {'title': 'Patient Safety', 'desc': 'Proactive risk management.'},
    ],
    'Tech / Innovation Partner': [
      {'title': 'API Integrations', 'desc': 'Plug-and-play with EHRs.'},
      {'title': 'Custom Workflows', 'desc': 'Tailored AI solutions.'},
      {'title': 'Data Security', 'desc': 'HIPAA-grade privacy.'},
      {'title': 'Innovation Sandbox', 'desc': 'Test and deploy rapidly.'},
    ],
    'Consumer / Family / Wellness': [
      {'title': 'Personal Health Insights', 'desc': 'AI for daily wellness.'},
      {'title': 'Care Navigation', 'desc': 'Find the right resources.'},
      {'title': 'Remote Monitoring', 'desc': 'Stay connected to care.'},
      {'title': 'Family Engagement', 'desc': 'Tools for loved ones.'},
    ],
  };

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

  void _onTopicTap(int idx) async {
    await _controller.reverse();
    final topics = roleTopics[widget.role] ?? [];
    final topic = topics[idx];
    await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => InfoModal(
        title: topic['title']!,
        body: topic['desc']!,
        onClose: () => Navigator.of(context).pop(),
      ),
    );
    _controller.forward();
  }

  void _onSignupTap() async {
    await _controller.reverse();
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => SignupModal(
        onClose: () => Navigator.of(context).pop(),
      ),
    );
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final topics = roleTopics[widget.role] ?? [];
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
                  widget.role,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: FadeTransitionWidget(
                  animation: _fadeAnim,
                  child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 32,
                    crossAxisSpacing: 32,
                    childAspectRatio: 1.6,
                    children: List.generate(topics.length, (i) {
                      final topic = topics[i];
                      return GestureDetector(
                        onTap: () => _onTopicTap(i),
                        child: Container(
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
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                topic['title']!,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                topic['desc']!,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              CustomButton(
                text: 'Sign up for updates and insights',
                onTap: _onSignupTap,
                width: 420,
                height: 64,
                backgroundColor: continuoBlue,
                textColor: Colors.white,
                fontSize: 20,
                borderRadius: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
