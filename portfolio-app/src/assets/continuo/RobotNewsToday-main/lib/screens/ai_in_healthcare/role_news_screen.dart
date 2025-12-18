import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../widgets/back_button.dart';
import '../../widgets/fade_transition_widget.dart';
import '../../utils/theme.dart';
import 'news_story_detail_screen.dart';
import '../contact/contact_screen.dart';

class RoleNewsScreen extends StatefulWidget {
  final String role;

  const RoleNewsScreen({
    super.key,
    required this.role,
  });

  @override
  State<RoleNewsScreen> createState() => _RoleNewsScreenState();
}

class _RoleNewsScreenState extends State<RoleNewsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnim;
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

          // Get role-specific perspective and icon
          final perspective = _getRolePerspective(i, widget.role);
          final iconData = _getStoryIcon(i);

          // Check for role-specific image first, then fallback to general image
          String? imagePath;
          final roleFolder = _getRoleFolder(widget.role);

          // Force role-specific paths first
          if (roleFolder == 'nurse' ||
              roleFolder == 'provider' ||
              roleFolder == 'tech') {
            try {
              // Try role-specific PNG image first
              await rootBundle
                  .load('assets/news/images/$roleFolder/story_${i}_image.png');
              imagePath = 'assets/news/images/$roleFolder/story_${i}_image.png';
              print('SUCCESS: Loading $imagePath for ${widget.role}');
            } catch (e) {
              print(
                  'FAILED: Could not load role-specific PNG for $roleFolder/story_${i}_image.png');
              // Fallback to general JPG
              try {
                await rootBundle
                    .load('assets/news/images/story_${i}_image.jpg');
                imagePath = 'assets/news/images/story_${i}_image.jpg';
                print('FALLBACK: Loading general JPG for ${widget.role}');
              } catch (e) {
                print(
                    'ERROR: No image found at all for story $i, role ${widget.role}');
              }
            }
          } else {
            // For roles without specific images (consumer, leader), use general JPG
            try {
              await rootBundle.load('assets/news/images/story_${i}_image.jpg');
              imagePath = 'assets/news/images/story_${i}_image.jpg';
              print('GENERAL: Loading JPG for ${widget.role}');
            } catch (e) {
              print('ERROR: No general JPG found for story $i');
            }
          }

          stories.add({
            'title': header.trim(),
            'content': content,
            'perspective': perspective,
            'icon': iconData.codePoint.toString(),
            'image': imagePath ?? '',
          });
        } catch (e) {
          print('Error loading story $i: $e');
        }
      }

      setState(() {
        newsStories = stories;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading news stories: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  String _getRolePerspective(int storyIndex, String role) {
    // Define role-specific perspectives for each story
    final perspectives = {
      'Nurse / Frontline Staff': {
        1: 'As a frontline nurse, autonomous robotic surgery fundamentally changes your perioperative workflow. You\'ll be trained on new protocols for robotic system preparation, sterile field management around AI-guided instruments, and real-time patient monitoring during autonomous procedures. Your role shifts from direct surgical assistance to becoming a specialized coordinator who ensures seamless communication between the surgical team and robotic systems.\n\nThis technology reduces your physical strain during long procedures while requiring new competencies in robotic troubleshooting and patient advocacy during AI-assisted care.',
        2: 'Remote patient monitoring transforms your daily practice by extending your care beyond hospital walls. You\'ll interpret continuous streams of vital signs, medication adherence data, and patient-reported symptoms from wearable devices and home monitoring systems. This requires developing new skills in data analysis, virtual patient assessment, and proactive intervention protocols.\n\nYour workday will include virtual check-ins, trend analysis of patient metrics, and coordinating care plans based on predictive alerts, positioning you as a proactive health guardian.',
        3: 'AI diagnostic tools become your clinical decision-making partner, providing real-time analysis of symptoms, lab values, and imaging results. You\'ll work alongside AI systems that flag potential diagnoses, drug interactions, and care protocol recommendations, enhancing your ability to catch early warning signs.\n\nYour role evolves to include validating AI recommendations against your clinical intuition and serving as the human interface between algorithmic decisions and compassionate patient care.',
        4: 'Predictive analytics empowers you to identify high-risk patients before they deteriorate, fundamentally changing your approach from reactive to preventive care. You\'ll receive alerts about patients likely to develop complications, fall risks, or those who may require urgent interventions.\n\nThis technology helps you prioritize your time more effectively, focusing intensive monitoring on vulnerable patients while spending more time on proactive interventions and patient education.',
        5: 'AI-powered scheduling optimizes your workflow by intelligently managing patient assignments, procedure timing, and resource allocation based on acuity levels and your specific skill sets. The system learns from historical patterns to predict staffing needs and ensure appropriate nurse-to-patient ratios.\n\nThis means fewer last-minute schedule changes, better work-life balance, and more predictable workloads while reducing burnout through more efficient work environments.',
        6: 'Enhanced telemedicine platforms expand your reach to provide comprehensive patient care beyond traditional bedside interactions. You\'ll conduct virtual assessments, medication education sessions, and post-discharge follow-ups using advanced video technology that captures vital signs remotely.\n\nThis requires developing new communication skills for virtual care delivery while maintaining therapeutic relationships and extending your impact to serve more patients.',
        7: 'Smart medication systems revolutionize medication administration by providing real-time verification, drug interaction alerts, and automated documentation. These AI-powered systems help prevent medication errors through multiple verification checkpoints.\n\nYour role becomes more focused on patient education about medications and monitoring therapeutic effectiveness, spending less time on manual verification and more on clinical assessment.',
      },
      'Provider (MD/NP/PA)': {
        1: 'Autonomous surgical systems expand your operative capabilities by handling routine procedural components while you focus on complex decision-making and patient safety oversight. These AI-guided robots perform precise suturing and tissue manipulation with sub-millimeter accuracy, reducing fatigue during lengthy procedures.\n\nThis technology allows you to supervise multiple surgical suites and extend your expertise to remote locations, ultimately expanding your surgical volume and precision while reducing physical demands.',
        2: 'Continuous patient monitoring provides unprecedented real-time insights into patient health status between appointments. You\'ll receive comprehensive data streams from wearable devices and home monitoring systems that enable proactive treatment adjustments and early intervention protocols.\n\nThis transforms your practice from episodic care to continuous health management, allowing you to detect subtle changes, optimize medication dosing, and prevent hospitalizations through timely interventions.',
        3: 'AI diagnostic tools enhance your clinical reasoning by providing rapid analysis of complex symptom presentations and suggesting differential diagnoses based on comprehensive data analysis. These systems process vast amounts of medical literature and diagnostic patterns to support your clinical judgment.\n\nYou\'ll have access to AI-generated insights that reveal subtle patterns, rare conditions, or drug interactions, accelerating your diagnostic process and improving accuracy.',
        4: 'Predictive models help you identify patients who need immediate intervention before they present with acute symptoms. These AI systems analyze patient data patterns to predict complications, hospitalizations, or medication adjustment needs.\n\nYou\'ll receive risk stratification alerts that help prioritize your patient panel and implement preventive measures, allowing you to prevent emergencies and optimize chronic disease management.',
        5: 'AI scheduling systems optimize your clinical time by intelligently managing appointment types, duration, and complexity based on patient needs and your availability patterns. The system learns from your practice to maximize productivity while ensuring adequate time for complex cases.\n\nThis reduces administrative burden, minimizes scheduling conflicts, and ensures optimal patient access while you spend more time on direct patient care.',
        6: 'Advanced telehealth platforms enable you to deliver comprehensive care that rivals in-person visits through high-definition video, remote diagnostic tools, and real-time vital sign monitoring. You can conduct thorough virtual examinations and maintain therapeutic relationships across distances.\n\nThis expands your practice reach to serve patients in remote areas and provide convenient care options while developing new virtual examination skills.',
        7: 'Intelligent prescribing systems support your medication decisions with real-time analysis of drug interactions, dosing optimization, and patient-specific factors including genetics and concurrent medications. These AI tools help ensure optimal therapeutic outcomes.\n\nYou\'ll have decision support that considers patient adherence patterns, cost considerations, and real-world effectiveness data, enhancing prescribing confidence and reducing medication errors.',
      },
      'Leader / Quality / Operations': {
        1: 'Robotic surgery implementation offers significant strategic advantages including reduced operative costs, shorter patient stays, and improved surgical outcomes that enhance your organization\'s competitive position. These systems address critical surgeon shortage issues while standardizing care quality across facilities.\n\nYou\'ll see improvements in patient satisfaction scores, reduced malpractice exposure, and the ability to expand surgical services to smaller facilities through remote supervision, creating new revenue opportunities.',
        2: 'Remote patient monitoring technology directly impacts your bottom line by reducing readmission rates, preventing costly emergency department visits, and enabling earlier discharge with continued monitoring. This supports value-based care contracts by improving population health outcomes while reducing per-patient costs.\n\nYou\'ll achieve better patient satisfaction scores and improved chronic disease management while positioning your organization for success in value-based payment models.',
        3: 'AI diagnostic systems improve your quality metrics by reducing diagnostic errors, decreasing time to appropriate treatment, and ensuring consistent application of evidence-based protocols. This directly impacts patient safety scores, reduces liability exposure, and improves regulatory compliance.\n\nAccurate AI-assisted diagnostics reduce unnecessary testing, prevent delayed diagnoses, and improve coding accuracy for optimal reimbursement while reducing costs associated with diagnostic errors.',
        4: 'Predictive analytics transforms your resource allocation by forecasting patient acuity, staffing needs, and capacity requirements with unprecedented accuracy. This enables proactive management of census fluctuations, reduces overtime costs, and optimizes staff scheduling.\n\nYou\'ll achieve better financial performance through reduced readmissions and more efficient resource utilization while enabling data-driven decisions that improve operational efficiency.',
        5: 'AI scheduling systems dramatically improve operational efficiency by optimizing provider productivity, reducing patient wait times, and maximizing facility utilization. This directly impacts patient satisfaction scores and revenue optimization through better resource allocation.\n\nYou\'ll see improvements in access metrics, reduced no-show rates, and better staff utilization patterns that improve both cost management and quality outcomes.',
        6: 'Telemedicine platforms expand your market reach while reducing operational overhead, enabling you to serve patients across wider geographic areas without additional facility investments. This supports new service lines and creates competitive advantages in patient convenience.\n\nTelehealth reduces facility costs, enables higher provider productivity, and supports new revenue streams while achieving better patient retention and improved access scores.',
        7: 'Smart medication systems significantly improve patient safety metrics while reducing pharmacy operational costs and liability exposure. These systems prevent costly medication errors and improve medication adherence rates that impact readmission prevention.\n\nYou\'ll see improvements in patient safety indicators, reduced pharmacy waste through better inventory management, and enhanced regulatory compliance through automated documentation.',
      },
      'Tech / Innovation Partner': {
        1: 'Robotic surgical systems present extensive integration opportunities with existing hospital infrastructure including OR management systems, electronic health records, and imaging platforms. Your expertise in API development, real-time data processing, and system interoperability becomes crucial for seamless implementation.\n\nTechnical challenges include ensuring low-latency communication between robotic systems and hospital networks, implementing cybersecurity measures, and developing machine learning algorithms for surgical optimization.',
        2: 'IoT sensor networks for patient monitoring require sophisticated cloud infrastructure, edge computing solutions, and real-time analytics platforms capable of processing continuous physiological data streams. Your role involves designing scalable architectures that handle massive data volumes while ensuring HIPAA compliance.\n\nKey technical areas include developing predictive algorithms for early warning systems, secure data transmission protocols, and machine learning models that distinguish between normal variations and clinically significant changes.',
        3: 'AI diagnostic implementation requires robust machine learning infrastructure, comprehensive data pipelines, and sophisticated algorithm development for medical image analysis and clinical decision support. Your expertise in deep learning and clinical data integration becomes essential.\n\nTechnical challenges include training models on diverse medical datasets, ensuring algorithmic fairness, and developing explainable AI systems that clinicians can trust and understand.',
        4: 'Predictive analytics platforms require advanced data science capabilities, real-time processing infrastructure, and sophisticated modeling techniques for complex healthcare datasets. Your role involves developing algorithms that predict patient outcomes and intervention opportunities with high accuracy.\n\nTechnical implementation includes building scalable data warehouses, feature engineering pipelines, and machine learning models that adapt to changing patient populations and clinical practices.',
        5: 'Intelligent scheduling systems require optimization algorithms, constraint satisfaction programming, and real-time resource management platforms that balance provider preferences, patient needs, and operational efficiency requirements.\n\nYour technical work involves developing multi-objective optimization algorithms, APIs for system integration, and machine learning models that predict optimal scheduling patterns based on historical data.',
        6: 'Next-generation telehealth platforms require advanced video processing capabilities, secure communication protocols, and integration systems that connect with existing healthcare IT infrastructure. Your expertise in cybersecurity and cloud computing becomes crucial for scalable virtual care solutions.\n\nTechnical challenges include implementing end-to-end encryption, developing low-latency video systems, and creating interoperability solutions that integrate telehealth data with electronic health records.',
        7: 'Smart medication systems require sophisticated database integration, real-time monitoring capabilities, and decision support algorithms that process complex drug interaction data and patient-specific factors. Your role involves developing APIs for pharmacy integration and machine learning models for medication optimization.\n\nTechnical implementation includes building comprehensive drug databases, algorithms for personalized dosing recommendations, and predictive models that identify patients at risk for adverse drug events.',
      },
      'Consumer / Family / Wellness': {
        1: 'Autonomous robotic surgery offers your family access to more precise surgical procedures with potentially faster recovery times and reduced complications. These advanced systems perform intricate operations with sub-millimeter precision, meaning shorter hospital stays and quicker return to normal activities.\n\nAs surgical robots become widespread, you\'ll have access to consistent, high-quality surgical care and specialized expertise through remote supervision, reducing travel and disruption to family life.',
        2: 'Home monitoring devices transform how you manage chronic conditions and support aging family members by providing continuous health tracking from home. These systems monitor vital signs and alert healthcare providers to concerning changes before they become emergencies.\n\nFor families caring for elderly parents, these technologies provide peace of mind through early warning systems and reduce the burden of frequent medical appointments while enabling treatment adjustments based on daily patterns.',
        3: 'AI-powered health screening can detect potential health issues earlier than ever before, potentially identifying problems before you or your family experience symptoms. This technology analyzes health data, family history, and lifestyle factors to provide personalized risk assessments.\n\nEarly detection through AI screening can lead to more effective treatments, better outcomes, and lower healthcare costs while enabling proactive rather than reactive healthcare management for your family.',
        4: 'Predictive health analytics provide personalized alerts and recommendations that help prevent health emergencies and hospital visits. These systems analyze your family\'s health patterns to predict when someone might be at risk for complications or health deterioration.\n\nThis means fewer unexpected emergency room visits, better chronic condition management, and proactive guidance on when to seek medical attention and how to optimize daily health routines.',
        5: 'AI-powered scheduling makes accessing healthcare much more convenient by reducing wait times, optimizing appointment availability, and providing flexible scheduling options that work with your family\'s busy lifestyle. The system learns patterns to predict optimal appointment times.\n\nThis means easier access to care, fewer missed appointments due to conflicts, and more efficient healthcare visits with better coordination between family members\' appointments.',
        6: 'Advanced virtual healthcare platforms enable convenient medical consultations from your home, reducing travel time, childcare needs, and time away from work while maintaining high-quality medical care. These systems provide comprehensive virtual examinations for many health concerns.\n\nTelehealth offers flexibility for evening or weekend care, reduces waiting room exposure to illness, and enables more frequent chronic condition check-ins without disrupting daily routines.',
        7: 'Smart medication management systems help prevent dangerous medication errors through automated verification, drug interaction checking, and personalized dosing recommendations. These systems provide reminders and track medication adherence.\n\nFor families managing multiple medications, these technologies provide safety nets that reduce harmful drug interactions, ensure consistent medication management, and provide early alerts about potential problems.',
      },
    };

    return perspectives[role]?[storyIndex] ??
        'Discover how this healthcare innovation impacts your daily experience.';
  }

  String _getRoleFolder(String role) {
    // Map role names to folder names
    switch (role) {
      case 'Nurse / Frontline Staff':
        return 'nurse';
      case 'Provider (MD/NP/PA)':
        return 'provider';
      case 'Leader / Quality / Operations':
        return 'leader';
      case 'Tech / Innovation Partner':
        return 'tech';
      case 'Consumer / Family / Wellness':
        return 'consumer';
      default:
        return 'general';
    }
  }

  IconData _getStoryIcon(int storyIndex) {
    // Get role-specific icons for each story
    final roleIcons = {
      'Nurse / Frontline Staff': {
        1: Icons.medical_services, // Robotic Surgery - Medical services
        2: Icons.monitor_heart, // Remote Monitoring - Heart monitor
        3: Icons.health_and_safety, // AI Diagnostics - Health & safety
        4: Icons.priority_high, // Predictive Analytics - Priority alerts
        5: Icons.schedule, // AI Scheduling - Schedule
        6: Icons.video_call, // Telemedicine - Video call
        7: Icons.medication_liquid, // Smart Medication - Liquid medication
      },
      'Provider (MD/NP/PA)': {
        1: Icons.precision_manufacturing, // Robotic Surgery - Precision tools
        2: Icons.timeline, // Remote Monitoring - Timeline/trends
        3: Icons.psychology, // AI Diagnostics - Psychology/analysis
        4: Icons.trending_up, // Predictive Analytics - Trending up
        5: Icons.event_available, // AI Scheduling - Event available
        6: Icons.video_chat, // Telemedicine - Video chat
        7: Icons.science, // Smart Medication - Science/prescribing
      },
      'Leader / Quality / Operations': {
        1: Icons.business_center, // Robotic Surgery - Business operations
        2: Icons.analytics, // Remote Monitoring - Analytics
        3: Icons.assessment, // AI Diagnostics - Assessment
        4: Icons.insights, // Predictive Analytics - Insights
        5: Icons.dashboard, // AI Scheduling - Dashboard
        6: Icons.language, // Telemedicine - Global reach
        7: Icons.security, // Smart Medication - Safety/security
      },
      'Tech / Innovation Partner': {
        1: Icons.smart_toy, // Robotic Surgery - Smart robotics
        2: Icons.sensors, // Remote Monitoring - Sensors
        3: Icons.memory, // AI Diagnostics - AI/memory
        4: Icons.data_usage, // Predictive Analytics - Data usage
        5: Icons.settings, // AI Scheduling - System settings
        6: Icons.cloud_sync, // Telemedicine - Cloud sync
        7: Icons.developer_mode, // Smart Medication - Developer mode
      },
      'Consumer / Family / Wellness': {
        1: Icons.family_restroom, // Robotic Surgery - Family care
        2: Icons.home, // Remote Monitoring - Home monitoring
        3: Icons.health_and_safety, // AI Diagnostics - Health screening
        4: Icons.warning, // Predictive Analytics - Early warnings
        5: Icons.calendar_today, // AI Scheduling - Easy scheduling
        6: Icons.smartphone, // Telemedicine - Mobile convenience
        7: Icons.medication, // Smart Medication - Safe medication
      },
    };

    return roleIcons[widget.role]?[storyIndex] ?? Icons.article;
  }

  void _onStoryTap(int index) async {
    await _controller.reverse();
    final story = newsStories[index];
    await Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, anim1, anim2) => NewsStoryDetailScreen(
          title: story['title']!,
          content: story['content']!,
          imagePath: story['image']!.isNotEmpty ? story['image']! : null,
        ),
        transitionsBuilder: (context, anim, _, child) =>
            FadeTransition(opacity: anim, child: child),
        transitionDuration: const Duration(milliseconds: 600),
      ),
    );
    _controller.forward();
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
  void dispose() {
    _controller.dispose();
    super.dispose();
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
              // Very compact top bar with back button, tiny logo, and contact button
              Stack(
                children: [
                  // Back button positioned absolutely on the left
                  Positioned(
                    left: 0,
                    top: 0,
                    child: BackButtonTopBar(),
                  ),
                  // Very small logo centered
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
                      onPressed: _onContactTap,
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
              Center(
                child: Column(
                  children: [
                    Text(
                      widget.role,
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'AI Healthcare News - Your Perspective',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: continuoBlue,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: FadeTransitionWidget(
                  animation: _fadeAnim,
                  child: _isLoading
                      ? const Center(child: CircularProgressIndicator())
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
                          : GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1.3,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                              ),
                              itemCount: newsStories.length,
                              itemBuilder: (context, i) {
                                final story = newsStories[i];
                                final iconCode = int.tryParse(story['icon']!) ??
                                    Icons.article.codePoint;

                                return GestureDetector(
                                  onTap: () => _onStoryTap(i),
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
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
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Large image at the top
                                        Container(
                                          width: double.infinity,
                                          height: 165,
                                          decoration: BoxDecoration(
                                            color:
                                                continuoBlue.withOpacity(0.1),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: story['image']!.isNotEmpty
                                                ? Image.asset(
                                                    story['image']!,
                                                    fit: BoxFit.contain,
                                                    errorBuilder: (context,
                                                        error, stackTrace) {
                                                      return Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(20),
                                                        child: Icon(
                                                          IconData(iconCode,
                                                              fontFamily:
                                                                  'MaterialIcons'),
                                                          color: continuoBlue,
                                                          size: 40,
                                                        ),
                                                      );
                                                    },
                                                  )
                                                : Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            20),
                                                    child: Icon(
                                                      IconData(iconCode,
                                                          fontFamily:
                                                              'MaterialIcons'),
                                                      color: continuoBlue,
                                                      size: 40,
                                                    ),
                                                  ),
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        // Title and arrow row
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                story['title']!,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium
                                                    ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16,
                                                    ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            const Icon(
                                              Icons.arrow_forward_ios,
                                              color: continuoBlue,
                                              size: 16,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  story['perspective']!,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall
                                                      ?.copyWith(
                                                        fontSize: 12,
                                                        height: 1.3,
                                                      ),
                                                ),
                                              ),
                                              const SizedBox(height: 6),
                                              Text(
                                                'Tap to read more...',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(
                                                      color: continuoBlue,
                                                      fontSize: 11,
                                                      fontStyle:
                                                          FontStyle.italic,
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
