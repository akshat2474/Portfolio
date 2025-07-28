import 'package:akshat_portfolio/widgets/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'theme/app_theme.dart';
import 'widgets/about_me.dart' hide AppTheme;
import 'widgets/technical_skills.dart';
import 'widgets/projects.dart';
import 'widgets/personal_interests.dart';
import 'dart:ui';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  print("⏳ Loading .env...");
  await dotenv.load(fileName: ".env");
  print("✅ .env loaded!");
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

  // State to track scroll position for dynamic app bar styling
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent, // Make app bar transparent
            elevation: 0,
            pinned: true,
            floating: true,
            toolbarHeight: 80,
            flexibleSpace: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    color: _isScrolled
                        ? AppTheme.backgroundColor.withOpacity(0.7)
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
                                  text: 'About',
                                  onPressed: () => _scrollToSection(_aboutKey)),
                              _HoverNavButton(
                                  text: 'Skills',
                                  onPressed: () =>
                                      _scrollToSection(_skillsKey)),
                              _HoverNavButton(
                                  text: 'Projects',
                                  onPressed: () =>
                                      _scrollToSection(_projectsKey)),
                              _HoverNavButton(
                                  text: 'Interests',
                                  onPressed: () =>
                                      _scrollToSection(_interestsKey)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            titleSpacing: 0,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              AboutMeSection(key: _aboutKey),
              TechnicalSkillsSection(key: _skillsKey),
              ProjectsSection(key: _projectsKey),
              PersonalInterestsSection(key: _interestsKey),
              const SizedBox(height: 100),
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