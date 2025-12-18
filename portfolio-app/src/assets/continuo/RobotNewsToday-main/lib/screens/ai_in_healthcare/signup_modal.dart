import 'package:flutter/material.dart';
import '../../utils/theme.dart';
import '../../utils/signup_manager_factory.dart';

class SignupModal extends StatefulWidget {
  final VoidCallback onClose;
  const SignupModal({super.key, required this.onClose});

  @override
  State<SignupModal> createState() => _SignupModalState();
}

class _SignupModalState extends State<SignupModal> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String email = '';
  String organization = '';
  String title = '';
  String role = '';
  String interests = '';
  bool submitted = false;

  Future<void> _submit() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      // Save signup using factory pattern
      try {
        final manager = SignupManagerFactory.createManager();
        await manager.saveSignup(
          name: name,
          email: email,
          organization: organization,
          title: title,
          role: role,
          interests: interests,
        );

        setState(() => submitted = true);
        await Future.delayed(const Duration(milliseconds: 900));
        widget.onClose();
      } catch (e) {
        // Show error message if save failed
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to save signup: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
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
          child: Material(
            borderRadius: BorderRadius.circular(20),
            elevation: 8,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.7,
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  if (!submitted)
                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sign up for updates and insights.',
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 24),
                          TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'Full Name'),
                            onSaved: (v) => name = v ?? '',
                            validator: (v) =>
                                (v == null || v.isEmpty) ? 'Required' : null,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'Email'),
                            onSaved: (v) => email = v ?? '',
                            validator: (v) => (v == null || !v.contains('@'))
                                ? 'Enter a valid email'
                                : null,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Organization'),
                            onSaved: (v) => organization = v ?? '',
                            validator: (v) =>
                                (v == null || v.isEmpty) ? 'Required' : null,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'Job Title'),
                            onSaved: (v) => title = v ?? '',
                            validator: (v) =>
                                (v == null || v.isEmpty) ? 'Required' : null,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Role/Department'),
                            onSaved: (v) => role = v ?? '',
                            validator: (v) =>
                                (v == null || v.isEmpty) ? 'Required' : null,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Areas of Interest'),
                            onSaved: (v) => interests = v ?? '',
                            validator: (v) =>
                                (v == null || v.isEmpty) ? 'Required' : null,
                          ),
                          const SizedBox(height: 32),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: continuoBlue,
                                foregroundColor: Colors.white,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 18),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: _submit,
                              child: const Text('Submit',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (submitted)
                    Center(
                      child: AnimatedOpacity(
                        opacity: submitted ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 400),
                        child: const Text(
                          'Thank you!',
                          style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: continuoBlue),
                        ),
                      ),
                    ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      icon: const Icon(Icons.close,
                          size: 32, color: continuoBlue),
                      onPressed: widget.onClose,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
