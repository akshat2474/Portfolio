import 'package:akshat_portfolio/widgets/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'theme/app_theme.dart';
import 'widgets/about_me.dart' ;
import 'widgets/technical_skills.dart';
import 'widgets/projects.dart';
import 'widgets/personal_interests.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: "dotenv");
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Akshat Singh',
      theme: AppTheme.darkTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PortfolioHome extends StatefulWidget {
  const PortfolioHome({super.key});

  @override
  State<PortfolioHome> createState() => _PortfolioHomeState();
}

class _PortfolioHomeState extends State<PortfolioHome> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _interestsKey = GlobalKey();

  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.offset > 50 && !_isScrolled) {
      setState(() {
        _isScrolled = true;
      });
    } else if (_scrollController.offset <= 50 && _isScrolled) {
      setState(() {
        _isScrolled = false;
      });
    }
  }

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  void _downloadResume() {
    launchUrl(Uri.parse('assets/resume/Resume.pdf'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            pinned: true,
            floating: true,
            toolbarHeight: 80,
            flexibleSpace: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                color: _isScrolled
                    ? AppTheme.backgroundColor.withValues(alpha: .85)
                    : Colors.transparent,
                border: Border(
                  bottom: BorderSide(
                    color: _isScrolled
                        ? AppTheme.borderColor
                        : Colors.transparent,
                    width: 1,
                  ),
                ),
              ),
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Akshat Singh',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _HoverNavButton(
                              text: 'Resume',
                              onPressed: _downloadResume),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            titleSpacing: 0,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              AboutMeSection(
                key: _aboutKey,
                onViewWorkPressed: () => _scrollToSection(_projectsKey),
              ),
              TechnicalSkillsSection(key: _skillsKey),
              ProjectsSection(key: _projectsKey),
              PersonalInterestsSection(key: _interestsKey),
            ]),
          ),
        ],
      ),
    );
  }
}

class _HoverNavButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;

  const _HoverNavButton({required this.text, required this.onPressed});

  @override
  __HoverNavButtonState createState() => __HoverNavButtonState();
}

class __HoverNavButtonState extends State<_HoverNavButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final hoveredColor = AppTheme.primaryColor;
    final nonHoveredColor = AppTheme.textSecondary;

    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      cursor: SystemMouseCursors.click,
      child: InkWell(
        onTap: widget.onPressed,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.text,
                style: GoogleFonts.poppins(
                  color: _isHovered ? hoveredColor : nonHoveredColor,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 4),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 2,
                width: _isHovered ? 20 : 0,
                color: hoveredColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });
  }
}