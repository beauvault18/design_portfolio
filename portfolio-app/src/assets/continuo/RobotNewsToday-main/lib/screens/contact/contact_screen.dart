import 'package:flutter/material.dart';
import '../../widgets/back_button.dart';
import '../../utils/theme.dart';
import '../../utils/contact_data_manager.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  
  bool _newsletterSignup = false;
  bool _requestCallback = false;
  bool _isSubmitting = false;
  bool _showThankYou = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // At least name and one contact method (email or phone) required
    if (_nameController.text.trim().isEmpty || 
        (_emailController.text.trim().isEmpty && _phoneController.text.trim().isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please provide your name and at least one contact method (email or phone)'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      final contactData = {
        'name': _nameController.text.trim(),
        'email': _emailController.text.trim(),
        'phone': _phoneController.text.trim(),
        'newsletterSignup': _newsletterSignup,
        'requestCallback': _requestCallback,
        'timestamp': DateTime.now().toIso8601String(),
      };

      await ContactDataManager.saveContactData(contactData);

      if (mounted) {
        // Show thank you screen
        setState(() {
          _showThankYou = true;
        });

        // Wait 3 seconds then navigate back
        await Future.delayed(const Duration(seconds: 3));
        
        if (mounted) {
          Navigator.of(context).pop(); // Go back to main menu
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error saving contact information. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: continuoBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
          child: _showThankYou ? _buildThankYouScreen() : _buildContactForm(),
        ),
      ),
    );
  }

  Widget _buildThankYouScreen() {
    return Column(
      children: [
        // Top bar with logo (no back button on thank you screen)
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
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Large logo
                Image.asset(
                  'assets/logo.png',
                  width: 300,
                  height: 150,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 40),
                // Thank you text
                Text(
                  'Thank You!',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF0072CE),
                    fontSize: 48,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Your contact information has been saved.',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.grey[600],
                    fontSize: 24,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContactForm() {
    return Column(
      children: [
        // Top bar with back button and logo
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
          ],
        ),
        const SizedBox(height: 24),
        Center(
          child: Text(
            'Contact Us',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: const Color(0xFF0072CE),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Center(
          child: Text(
            'Get in touch with our team',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.grey[600],
            ),
          ),
        ),
        const SizedBox(height: 32),
        Expanded(
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Name field
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'Full Name *',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      
                      // Email field
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email Address',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        validator: (value) {
                          if (value != null && value.isNotEmpty) {
                            final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                            if (!emailRegex.hasMatch(value)) {
                              return 'Please enter a valid email address';
                            }
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      
                      // Phone field
                      TextFormField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 24),
                      
                      // Newsletter checkbox
                      CheckboxListTile(
                        title: const Text('Subscribe to our newsletter'),
                        subtitle: const Text('Get updates on healthcare innovation'),
                        value: _newsletterSignup,
                        onChanged: (value) {
                          setState(() {
                            _newsletterSignup = value ?? false;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                        activeColor: const Color(0xFF0072CE),
                      ),
                      
                      // Callback checkbox
                      CheckboxListTile(
                        title: const Text('Request a callback'),
                        subtitle: const Text('Speak with our team about solutions'),
                        value: _requestCallback,
                        onChanged: (value) {
                          setState(() {
                            _requestCallback = value ?? false;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                        activeColor: const Color(0xFF0072CE),
                      ),
                      
                      const SizedBox(height: 32),
                      
                      // Submit button
                      ElevatedButton(
                        onPressed: _isSubmitting ? null : _submitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0072CE),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 2,
                        ),
                        child: _isSubmitting
                            ? const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Text('Saving...'),
                                ],
                              )
                            : const Text(
                                'Submit Contact Information',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Required fields note
                      Center(
                        child: Text(
                          '* Required fields\nPlease provide either email or phone number',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}