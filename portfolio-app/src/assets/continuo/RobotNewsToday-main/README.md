# Continuo iPad App

A professional-grade Flutter app for iPad, showcasing healthcare AI innovation and collecting contact information for business development.

## Features

### Core Functionality
- **iPad-optimized landscape UI** with professional healthcare branding
- **Interactive video demonstrations** with 50/50 split layout (video right, text left)
- **Contact collection system** with persistent local storage and admin export
- **Role-based news content** with personalized stories for different healthcare roles
- **Feature gallery** with 4 core product demonstrations
- **Admin dashboard** with PIN protection (1458) and contact export

### User Experience
- **Animated transitions** with fade effects throughout the app
- **Inactivity timer** (auto-reset to main menu after idle time)
- **Thank you flow** with 3-second logo display after contact submission
- **"Learn More" buttons** strategically placed across all screens
- **Professional typography** using SF Pro Display and healthcare-appropriate styling

### Content Management
- **Video content**: Transcription Intelligence, Bluetooth Vitals, Voice Vitals, Billing Codes
- **News stories**: Role-specific content for Nurses, Doctors, and Administrators
- **Contact persistence**: Data survives app restarts and exports to JSON

## Quick Start
1. **Install Flutter 3.19+**
2. **Clone this repo**
3. **Install dependencies:**
   ```
   flutter pub get
   ```
4. **Add assets** (fonts, images, videos) to respective `assets/` folders
5. **Run on iPad:**
   ```
   flutter run -d <ipad_device_id>
   ```

## Project Structure
```
lib/
├── main.dart                    # App entry point
├── screens/
│   ├── main_menu.dart          # Home screen with role selection
│   ├── continuo_in_action/     # Feature gallery and video demos
│   ├── ai_in_healthcare/       # News carousel and role content
│   ├── contact/                # Contact form and thank you screen
│   └── admin/                  # PIN-protected admin dashboard
├── widgets/                    # Reusable UI components
└── utils/                      # Theme, storage, inactivity timer

assets/
├── videos/                     # Feature demonstration videos
│   ├── transcription_intelligence.mov
│   ├── bluetooth_vitals_capture.mov
│   ├── voice_entered_vitals.mov
│   └── billing_code_review.mov
├── news/                       # Story content and images
└── fonts/                      # SF Pro Display font family
```

## Admin Access
1. **PIN Authentication**: Enter PIN `1458` to access admin dashboard
2. **Contact Export**: View submission count and export contacts as JSON
3. **Data Management**: All contact data persists between app sessions

## Build for Production
```bash
flutter build ios --release
flutter build apk --release
```

## Technical Details
- **Framework**: Flutter 3.19+
- **Platform**: iPad (landscape orientation only)
- **Storage**: Local JSON file persistence with path_provider
- **Video**: Custom video player with modal overlays
- **State Management**: StatefulWidget with manual state control
- **Navigation**: Custom page transitions with fade animations

## License
Proprietary – Continuo Health (vCare Companion)

---
*Built for healthcare innovation demonstrations and lead generation*
