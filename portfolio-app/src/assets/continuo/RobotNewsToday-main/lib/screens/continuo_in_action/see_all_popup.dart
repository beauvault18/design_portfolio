import 'package:flutter/material.dart';
import '../../utils/theme.dart';

class SeeAllPopup extends StatelessWidget {
  final Function(String) onSelect;
  final VoidCallback onClose;
  const SeeAllPopup({super.key, required this.onSelect, required this.onClose});

  static const List<String> categories = [
    'All',
    'Nurse / Frontline Staff',
    'Provider (MD/NP/PA)',
    'Leader / Quality / Operations',
    'Tech / Innovation Partner',
    'Consumer / Family / Wellness',
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: onClose,
          child: Container(
            color: Colors.black.withOpacity(0.4),
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        Center(
          child: Container(
            width: 480,
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.18),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Which of these best describe you?',
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 32),
                    ...categories.map((cat) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: continuoBlue,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 18),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () => onSelect(cat),
                              child: Text(cat, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                            ),
                          ),
                        )),
                  ],
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                    icon: const Icon(Icons.close, size: 32, color: continuoBlue),
                    onPressed: onClose,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
