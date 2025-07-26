import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'models/project_model.dart';
import 'models/song_model.dart';
import 'widgets/background_painter.dart';
import 'widgets/project_card.dart';
import 'widgets/tag_chip.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  late Song _currentSong;
  final Random _random = Random();

  static final List<Song> _favoriteSongs = [
    const Song(title: "Duniyaa", artist: "from Luka Chuppi"),
    const Song(title: "Starboy", artist: "The Weeknd ft. Daft Punk"),
    const Song(title: "Blinding Lights", artist: "The Weeknd"),
    const Song(title: "As It Was", artist: "Harry Styles"),
    const Song(title: "STAY", artist: "The Kid LAROI, Justin Bieber"),
    const Song(title: "INDUSTRY BABY", artist: "Lil Nas X, Jack Harlow"),
    const Song(title: "Run Away With Me", artist: "Carly Rae Jepsen"),
    const Song(title: "Call Me Maybe", artist: "Carly Rae Jepsen"),
    const Song(title: "Cut to the Feeling", artist: "Carly Rae Jepsen"),
    const Song(title: "I Really Like You", artist: "Carly Rae Jepsen"),
    const Song(title: "Want You in My Room", artist: "Carly Rae Jepsen"),
    const Song(title: "HUMBLE.", artist: "Kendrick Lamar"),
    const Song(title: "Money Trees", artist: "Kendrick Lamar ft. Jay Rock"),
    const Song(title: "Alright", artist: "Kendrick Lamar"),
    const Song(title: "DNA.", artist: "Kendrick Lamar"),
    const Song(title: "Not Like Us", artist: "Kendrick Lamar"),
    const Song(title: "Toxic", artist: "Britney Spears"),
    const Song(title: "...Baby One More Time", artist: "Britney Spears"),
    const Song(title: "Gimme More", artist: "Britney Spears"),
    const Song(title: "Womanizer", artist: "Britney Spears"),
    const Song(title: "Oops!... I Did It Again", artist: "Britney Spears"),
  ];

  @override
  void initState() {
    super.initState();
    _refreshSong();
  }

  void _refreshSong() {
    setState(() {
      _currentSong = _favoriteSongs[_random.nextInt(_favoriteSongs.length)];
    });
  }

  static const List<Project> projects = [
    Project(
      title: 'CarbonEye',
      liveUrl: 'https://akshat2474.github.io/CarbonEye/',
      description: 'A vision and analytics system for environmental analysis.',
      icon: FontAwesomeIcons.leaf,
      year: 2023,
      tags: ['Flutter', 'Python'],
      coreFeatures: ['API for programmatic analysis', 'Before/After satellite imagery comparison', 'Detailed reports on detected changes'],
      techStack: 'Flutter, Python, Google Earth Engine, ML/CV Models, Static Site Generation',
      implementationDetails: 'API documentation site built with a focus on clear code examples. Structured report generation.',
      gaps: 'Clarify model validation and measurement accuracy disclaimers. Offer SDK clients (Python/JS) for the API.',
    ),
    Project(
      title: 'Color Harmony',
      liveUrl: 'https://colorharmony-akshat.netlify.app/',
      description: 'A feature-rich color workflow app for designers and developers.',
      icon: FontAwesomeIcons.palette,
      year: 2024,
      tags: ['Flutter', 'Dart'],
      coreFeatures: ['6+ harmony algorithms', 'WCAG AA/AAA contrast checker', 'Drawing Pad', 'Image color extraction'],
      techStack: 'Flutter, Dart, palette_generator, flutter_colorpicker, shared_preferences, image_picker',
      implementationDetails: 'Clean separation of services and widgets. Accessibility checks abstracted into a dedicated service.',
      gaps: 'Consider CIE L*a*b* distance for perceptual uniformity. Add export to design tokens (CSS, Figma JSON).',
    ),
    Project(
      title: 'RetroDash',
      liveUrl: 'https://akshat-retro-dash.netlify.app/',
      description: 'A fast, retro-styled arcade shooter with stackable power-ups.',
      icon: FontAwesomeIcons.gamepad,
      year: 2024,
      tags: ['Flutter', 'Game Dev'],
      coreFeatures: ['Dual modes: Auto-fire and Manual', 'Stackable power-ups', 'Deterministic boss fights', 'Local leaderboard'],
      techStack: 'Flutter (desktop, mobile, web) with custom game loop and state management',
      implementationDetails: 'Clear widget modularization. Predictable progression curve via deterministic score thresholds.',
      gaps: 'Add deterministic enemy spawn seeds for replays. Implement frame-independent movement. Integrate cloud leaderboards.',
    ),
    Project(
      title: 'Hand2Hand',
      liveUrl: 'https://github.com/akshat2474/Hand2Hand',
      description: 'A tech-for-good app to route donations from volunteers to NGOs.',
      icon: FontAwesomeIcons.handHoldingHeart,
      year: 2023,
      tags: ['Flutter', 'Firebase'],
      coreFeatures: ['Geo-based notifications', 'Fallback logic to next nearest NGO', 'In-app notification inbox'],
      techStack: 'Flutter, Firebase (Auth, Firestore, Performance), flutter_map, Provider, GoRouter, Gemini API',
      implementationDetails: 'Fallback logic encapsulated in a custom widget. Simple but explicit Firestore collections.',
      gaps: 'Migrate fallback logic to Cloud Functions. Add Firestore security rules and transactional writes.',
    ),
     Project(
      title: 'TimeWise',
      liveUrl: 'https://github.com/akshat2474/TimeWise',
      description: 'A smart attendance tracker and timetable for students.',
      icon: FontAwesomeIcons.solidClock,
      year: 2022,
      tags: ['Flutter', 'Productivity'],
      coreFeatures: ['Calendar-based marking (Present, Absent, etc.)', 'Per-subject stats (how many classes you can skip)', '“What-if” calculator for planning', 'Charts, history, and CSV export.'],
      techStack: 'Flutter, Provider, shared_preferences, flutter_local_notifications, table_calendar, fl_chart, csv',
      implementationDetails: 'The “What-if calculator” provides excellent UX for students. Clean separation between data models (Subject, Timetable) and services (notifications, export).',
      gaps: 'Add cloud backup/sync (Firestore) so students don’t lose history. Add import from university timetables (CSV/ICS).',
    ),
    Project(
      title: 'TrainOS',
      liveUrl: 'https://github.com/akshat2474/TrainOS',
      description: 'A persistent fitness tracker with health scoring and analytics.',
      icon: FontAwesomeIcons.heartPulse,
      year: 2022,
      tags: ['Flutter', 'Health'],
      coreFeatures: ['Persistent step count (survives app restarts)', 'Personalized calorie & distance tracking', 'Manual sleep logging with weekly charts', 'Achievement system for consistency and milestones.'],
      techStack: 'Flutter, shared_preferences, fl_chart, Android NDK for desugaring',
      implementationDetails: 'Separate services per domain (fitness, sleep, health score), which keeps logic composable and testable. Explicit Android desugaring config to support modern libraries.',
      gaps: 'Integrate with Health Connect / Apple HealthKit instead of manual logging. Background step tracking on iOS requires a native bridge. Add goal-based coaching.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(painter: BackgroundPainter()),
          ),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
                children: [
                  _buildHeader(context),
                  const SizedBox(height: 48),
                  _buildIntroSection(context),
                  const SizedBox(height: 48),
                  _buildSectionTitle('CURRENTLY', context),
                  const SizedBox(height: 16),
                  _buildCurrentRole(context),
                  const SizedBox(height: 48),
                  _buildSectionTitle('RECENT PROJECTS', context),
                  const SizedBox(height: 16),
                  _buildProjectsSection(),
                  const SizedBox(height: 48),
                  _buildSectionTitle('TECHNOLOGIES', context),
                  const SizedBox(height: 24),
                  _buildTechnologiesGrid(),
                  const SizedBox(height: 48),
                  _buildSectionTitle('CURRENTLY LISTENING TO', context),
                  const SizedBox(height: 16),
                  _buildListeningSection(context),
                  const SizedBox(height: 48),
                  const Divider(color: Color(0xFF2A2A2A)),
                  const SizedBox(height: 16),
                  const Center(child: Text('© 2025 Akshat Singh', style: TextStyle(color: Colors.white38, fontSize: 12))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    void launchURL(String url) async {
      if (!await launchUrl(Uri.parse(url))) throw 'Could not launch $url';
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'AKSHAT SINGH',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Row(
          children: [
            IconButton(
              tooltip: 'GitHub',
              icon: const FaIcon(FontAwesomeIcons.github, size: 20),
              onPressed: () => launchURL('https://github.com/akshat2474'),
            ),
            IconButton(
              tooltip: 'LinkedIn',
              icon: const FaIcon(FontAwesomeIcons.linkedin, size: 20),
              onPressed: () => launchURL('https://www.linkedin.com/in/akshat-singh-48a03b312/'),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildSectionTitle(String title, BuildContext context) {
    return Text(title, style: Theme.of(context).textTheme.headlineSmall);
  }

  Widget _buildIntroSection(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CircleAvatar(
          radius: 36,
          backgroundImage: AssetImage('assets/images/avatar.png'),
          backgroundColor: Color(0xFF1A1A1A),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Hi, I'm Akshat Singh,",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 20)),
              const SizedBox(height: 8),
              Text(
                "a Flutter developer and tech enthusiast specializing in building beautiful, high-performance applications with a strong attention to detail.",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCurrentRole(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'CSE Student',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Row(
              children: [
                TagChip(label: 'DTU', icon: Icons.school_outlined),
              ],
            )
          ],
        ),
        const SizedBox(height: 4),
        Text(
          '2024 - PRESENT',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 12),
        Text(
          'Pursuing a degree in Computer Science and Engineering at Delhi Technological University, with a focus on software development and machine learning.',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }


  Widget _buildProjectsSection() {
    return SizedBox(
      height: 200,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: projects.length,
        separatorBuilder: (context, index) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          return ProjectCard(project: projects[index]);
        },
      ),
    );
  }

  Widget _buildTechnologiesGrid() {
    final technologies = {
      'Flutter': 'assets/images/flutter.svg',
      'Python': 'assets/images/python.svg',
      'Pytorch':'assets/images/pytorch.svg',
      'Scikit-Learn':'assets/images/scikitlearn.svg',
      'Tensorflow':'assets/images/tensorflow.svg',
      'Firebase': 'assets/images/firebase.svg',
      'Cpp': 'assets/images/cplusplus.svg',
      'Git': 'assets/images/git.svg',
      'Canva':'assets/images/canva.svg',
    };

    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: technologies.entries.map((entry) {
        return Tooltip(
          message: entry.key,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A1A),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFF2A2A2A)),
            ),
            child: SvgPicture.asset(
              entry.value,
              height: 32,
              width: 32,
              colorFilter:
                  const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildListeningSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF2A2A2A)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_currentSong.title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 16)),
              const SizedBox(height: 4),
              Text(_currentSong.artist, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
          TextButton(onPressed: _refreshSong, child: const Text("Refresh"))
        ],
      ),
    );
  }
}
