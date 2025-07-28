import '../models/project.dart';
import '../widgets/technical_skills.dart'; // Import to get Skill class definition

class DataService {
  static List<Project> getProjects() {
    return [
      Project(
        name: 'CarbonEye',
        overview: 'A sophisticated vision and analytics system designed for environmental analysis using satellite imagery to monitor environmental changes.',
        keyFeatures: [
          'API for Programmatic Analysis',
          'Before/After Satellite Imagery Comparison',
          'Detailed Environmental Reports',
          'Real-time Change Detection'
        ],
        technicalDetails: 'Built with Flutter frontend and Python backend, utilizing Google Earth Engine for satellite imagery and ML/CV models for analysis.',
        liveUrl: 'https://akshat2474.github.io/CarbonEye/',
        iconPath: 'assets/svg/flutter.svg',
        technologies: ['Flutter', 'Python', 'Google Earth Engine', 'ML/CV'],
      ),
      Project(
        name: 'Color Harmony',
        overview: 'A feature-rich color workflow application designed to assist designers and developers in creating beautiful and accessible color palettes.',
        keyFeatures: [
          '6+ Harmony Algorithms',
          'WCAG AA/AAA Contrast Checker',
          'Drawing Pad & Image Color Extraction',
          'Real-time Color Preview'
        ],
        technicalDetails: 'Built with Flutter and Dart, utilizing palette_generator for color extraction and flutter_colorpicker for interface.',
        liveUrl: 'https://colorharmony-akshat.netlify.app/',
        iconPath: 'assets/svg/dart.svg',
        technologies: ['Flutter', 'Dart', 'Color Theory'],
      ),
      Project(
        name: 'RetroDash',
        overview: 'A fast-paced, retro-styled arcade shooter that offers a classic gaming experience with modern features and engaging gameplay.',
        keyFeatures: [
          'Dual Modes (Auto-fire & Manual)',
          'Stackable Power-Ups',
          'Deterministic Boss Fights',
          'Local Leaderboard System'
        ],
        technicalDetails: 'Built with Flutter for cross-platform gaming, featuring custom game loop and state management with clear widget modularization.',
        liveUrl: 'https://akshat-retro-dash.netlify.app/',
        iconPath: 'assets/svg/flutter.svg',
        technologies: ['Flutter', 'Game Development', 'Custom Engine'],
      ),
      Project(
        name: 'Hand2Hand',
        overview: 'A "tech-for-good" application designed to streamline the donation process by connecting volunteers with NGOs in their area.',
        keyFeatures: [
          'Geo-Based Notifications',
          'Smart Fallback Logic',
          'In-App Notification Inbox',
          'Real-time NGO Matching'
        ],
        technicalDetails: 'Built with Flutter, utilizing Firebase for backend services, flutter_map for location features, and Gemini API integration.',
        githubUrl: 'https://github.com/akshat2474/Hand2Hand',
        iconPath: 'assets/svg/firebase.svg',
        technologies: ['Flutter', 'Firebase', 'Gemini API', 'Maps'],
      ),
      Project(
        name: 'TimeWise',
        overview: 'A smart attendance tracker and timetable application designed for students to stay organized and manage their academic schedule.',
        keyFeatures: [
          'Calendar-Based Marking',
          'Per-Subject Statistics',
          '"What-If" Calculator',
          'Charts, History & CSV Export'
        ],
        technicalDetails: 'Built with Flutter using Provider for state management, table_calendar for interface, and fl_chart for data visualization.',
        githubUrl: 'https://github.com/akshat2474/TimeWise',
        iconPath: 'assets/svg/flutter.svg',
        technologies: ['Flutter', 'Provider', 'Data Visualization'],
      ),
      Project(
        name: 'TrainOS',
        overview: 'A persistent fitness tracker that helps users monitor physical activity, sleep, and overall health with comprehensive analytics.',
        keyFeatures: [
          'Persistent Step Count',
          'Personalized Tracking',
          'Manual Sleep Logging',
          'Achievement System'
        ],
        technicalDetails: 'Built with Flutter using shared_preferences for persistence and fl_chart for analytics, with modular service architecture.',
        githubUrl: 'https://github.com/akshat2474/TrainOS',
        iconPath: 'assets/svg/flutter.svg',
        technologies: ['Flutter', 'Health APIs', 'Data Persistence'],
      ),
    ];
  }

  static Map<String, List<Skill>> getCategorizedSkills() {
    return {
      'Languages': [
        Skill(name: 'Dart', iconPath: 'assets/svg/dart.svg'),
        Skill(name: 'Python', iconPath: 'assets/svg/python.svg'),
        Skill(name: 'C++', iconPath: 'assets/svg/c++.svg'),
      ],
      'Frameworks & Libraries': [
        Skill(name: 'Flutter', iconPath: 'assets/svg/flutter.svg'),
        Skill(name: 'PyTorch', iconPath: 'assets/svg/pytorch.svg'),
        Skill(name: 'TensorFlow', iconPath: 'assets/svg/tensorflow.svg'),
        Skill(name: 'Scikit-Learn', iconPath: 'assets/svg/scikit-learn.svg'),
      ],
      'Tools & Platforms': [
        Skill(name: 'Firebase', iconPath: 'assets/svg/firebase.svg'),
        Skill(name: 'Git', iconPath: 'assets/svg/git.svg'),
        Skill(name: 'Canva', iconPath: 'assets/svg/canva.svg'),
      ],
    };
  }

  static List<String> getFavoriteArtists() {
    return ['The Weeknd', 'Kendrick Lamar', 'Carly Rae Jepsen', 'Britney Spears'];
  }
}
