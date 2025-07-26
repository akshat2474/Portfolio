import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'models/project_model.dart'; 
import 'widgets/project_card.dart';
import 'widgets/section_title.dart';
import 'widgets/background_painter.dart';
import 'widgets/skill_chip.dart';

class PortfolioPage extends StatelessWidget {
  const PortfolioPage({super.key});

  static final List<Project> projects = [
    Project(
      title: 'Color Harmony — Accessible Palette Designer',
      liveUrl: 'https://colorharmony-akshat.netlify.app/', // Link added
      description:
          'A feature-rich color workflow app for designers/devs that lets you generate, edit, test, and manage accessible color palettes, plus experiment with drawing, patterns, and image-based color extraction.',
      coreFeatures: [
        '6+ harmony algorithms (complementary, triadic, etc.)',
        'WCAG AA/AAA contrast checker',
        'Drawing Pad and Pattern Creator',
        'Image color extraction',
        'Saved palettes, search, and export flows.',
      ],
      techStack:
          'Flutter, Dart, palette_generator, flutter_colorpicker, shared_preferences, image_picker',
      implementationDetails:
          'Clean separation of services (color, storage, accessibility) and widgets. Accessibility checks abstracted into a dedicated service for reuse.',
      gaps:
          'Consider CIE L*a*b* distance for perceptual uniformity. Add export to design tokens (CSS, Figma JSON). Add cloud sync (Firebase) for collaborative workflows.',
    ),
    Project(
      title: 'RetroDash — Flutter Arcade Shooter',
      liveUrl: 'https://akshat-retro-dash.netlify.app/', // Link added
      description:
          'A fast, retro-styled arcade shooter with auto-fire mode, stackable power-ups, screen-clearing nukes, and challenging boss fights.',
      coreFeatures: [
        'Dual modes: Auto-fire and Manual',
        'Stackable power-ups and screen-clearing nukes',
        'Deterministic boss fights at score thresholds',
        'Local leaderboard and personal best tracking.',
      ],
      techStack:
          'Flutter (desktop, mobile, web) with custom game loop and state management',
      implementationDetails:
          'Clear widget modularization (animated background, audio player, boss logic). Predictable progression curve via deterministic score thresholds for power-ups.',
      gaps:
          'Add deterministic enemy spawn seeds to enable replays/speedruns. Implement frame-independent movement (time delta) for cross-platform consistency. Integrate Game Services for cloud leaderboards.',
    ),
    Project(
      title: 'CarbonEye — Emission Analysis API',
      liveUrl: 'https://akshat2474.github.io/CarbonEye/', // Link added
      description:
          'An analytics system for detecting and estimating carbon emissions or other environmental parameters from live camera feeds or static images.',
      coreFeatures: [
        'API for programmatic analysis',
        'Before/After satellite imagery comparison',
        'Detailed reports on detected changes',
        'Live analysis tool and code samples.',
      ],
      techStack:
          'Flutter, Python, Google Earth Engine, ML/CV Models, Static Site Generation',
      implementationDetails:
          'API documentation site built with a focus on clear code examples (Curl, JavaScript). Analysis results presented in a detailed, structured report.',
      gaps:
          'Clarify model validation and measurement accuracy disclaimers. Provide benchmark datasets and evaluation reports. Offer SDK clients (Python/JS) for the API.',
    ),
    Project(
      title: 'Hand2Hand — Volunteer ↔ NGO Routing',
      description:
          'A tech-for-good Flutter app that routes resource donations from volunteers to the nearest NGO, with auto-fallback if declined.',
      coreFeatures: [
        'Geo-based notifications to closest NGO',
        'Fallback logic to notify next nearest NGO',
        'In-app notification inbox',
        'Impact analytics and multi-language support on roadmap.',
      ],
      techStack:
          'Flutter, Firebase (Auth, Firestore, Performance), flutter_map, Provider, GoRouter, Gemini API',
      implementationDetails:
          'Fallback logic encapsulated in a custom widget. Simple but explicit Firestore collections (users, donations, notifications) with roles, status, and timestamps.',
      gaps:
          'Migrate fallback logic to Cloud Functions to avoid client-side vulnerabilities. Add Firestore security rules and transactional writes for consistency.',
    ),
    Project(
      title: 'TimeWise — Smart Attendance Tracker',
      description:
          'A student-first attendance tracker with custom timetables, daily calendar marking, analytics, and a what-if simulator to plan remaining classes.',
      coreFeatures: [
        'Calendar-based marking (Present, Absent, etc.)',
        'Per-subject stats (how many classes you can skip)',
        '“What-if” calculator for planning',
        'Charts, history, and CSV export.',
      ],
      techStack:
          'Flutter, Provider, shared_preferences, flutter_local_notifications, table_calendar, fl_chart, csv',
      implementationDetails:
          'The “What-if calculator” provides excellent UX for students. Clean separation between data models (Subject, Timetable) and services (notifications, export).',
      gaps:
          'Add cloud backup/sync (Firestore) so students don’t lose history. Add import from university timetables (CSV/ICS).',
    ),
    Project(
      title: 'TrainOS — Professional Fitness Tracker',
      description:
          'A persistent step tracker and sleep logger with health scoring, detailed analytics, and gamified achievements.',
      coreFeatures: [
        'Persistent step count (survives app restarts)',
        'Personalized calorie & distance tracking',
        'Manual sleep logging with weekly charts',
        'Achievement system for consistency and milestones.',
      ],
      techStack:
          'Flutter, shared_preferences, fl_chart, Android NDK for desugaring',
      implementationDetails:
          'Separate services per domain (fitness, sleep, health score), which keeps logic composable and testable. Explicit Android desugaring config to support modern libraries.',
      gaps:
          'Integrate with Health Connect / Apple HealthKit instead of manual logging. Background step tracking on iOS requires a native bridge. Add goal-based coaching.',
    ),
  ];
  //... rest of the PortfolioPage class

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: CustomPaint(painter: BackgroundPainter())),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                children: [
                  const SizedBox(height: 80),
                  _buildHeroSection(context),
                  const SizedBox(height: 80),

                  const SectionTitle(title: 'About Me'),
                  Text(
                    "I'm a passionate developer and student from India with a strong interest in mobile development using Flutter and exploring the world of Python and Machine Learning. I love building useful tools, solving complex problems, and continuously learning new technologies.",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 80),

                  const SectionTitle(title: 'Skills'),
                  _buildSkillsGrid(),
                  const SizedBox(height: 80),

                  const SectionTitle(title: 'My Projects'),
                  _buildProjectsList(), // Updated to a list
                  const SizedBox(height: 80),

                  const SectionTitle(title: 'Get In Touch'),
                  _buildContactSection(context),
                  const SizedBox(height: 80),

                  const Text(
                    '© 2025 Akshat Singh',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white38),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return Column(
      children: [
        Text(
          'Akshat Singh',
          style: Theme.of(context).textTheme.displayLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'Flutter Developer & Tech Enthusiast',
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(fontSize: 20, color: Colors.white70),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildSkillsGrid() {
    return const Center(
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        alignment: WrapAlignment.center,
        children: [
          SkillChip(label: 'Flutter'),
          SkillChip(label: 'Dart'),
          SkillChip(label: 'Python'),
          SkillChip(label: 'Firebase'),
          SkillChip(label: 'UI/UX Design'),
          SkillChip(label: 'REST APIs'),
          SkillChip(label: 'Git & GitHub'),
          SkillChip(label: 'Machine Learning'),
        ],
      ),
    );
  }

  // This new widget builds a list of your project cards
  Widget _buildProjectsList() {
    return Column(
      children:
          projects
              .map(
                (project) => Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: ProjectCard(project: project),
                ),
              )
              .toList(),
    );
  }

  Widget _buildContactSection(BuildContext context) {
    // Helper function for launching URLs
    void _launchURL(String url) async {
      if (!await launchUrl(Uri.parse(url))) {
        throw 'Could not launch $url';
      }
    }

    return Column(
      children: [
        Text(
          "I'm currently open to new opportunities and collaborations. Feel free to reach out if you have a project in mind or just want to connect!",
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),
        ElevatedButton(
          onPressed: () {
            _launchURL('mailto:your-email@example.com'); // Replace with your email
          },
          child: const Text('Say Hello'),
        ),
        const SizedBox(height: 24), // Spacing for social icons
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Tooltip(
              message: 'GitHub',
              child: IconButton(
                icon: const FaIcon(FontAwesomeIcons.github),
                iconSize: 32,
                onPressed: () => _launchURL('https://github.com/akshat2474'),
              ),
            ),
            const SizedBox(width: 24),
            Tooltip(
              message: 'LinkedIn',
              child: IconButton(
                icon: const FaIcon(FontAwesomeIcons.linkedin),
                iconSize: 32,
                onPressed: () =>
                    _launchURL('https://www.linkedin.com/in/akshat-singh-48a03b312/'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
