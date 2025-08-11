import 'package:akshat_portfolio/theme/theme_notifier.dart';
import 'package:akshat_portfolio/widgets/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'theme/app_theme.dart';
import 'widgets/about_me.dart';
import 'widgets/technical_skills.dart';
import 'widgets/projects.dart';
import 'widgets/personal_interests.dart';
import 'widgets/terminal.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: "dotenv");
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (context, themeNotifier, child) {
          return MaterialApp(
            title: 'Akshat Singh',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeNotifier.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            home: const SplashScreen(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
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
  bool _isTerminalMaximized = false;
  bool _showTerminal = false;
  OverlayEntry? _terminalOverlay;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _terminalOverlay?.remove();
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

  void _downloadResume() async {
    const url = 'assets/assets/resume/Resume.pdf';
    final uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      debugPrint('Could not launch $url');
    }
  }

  void _toggleTerminal() {
    setState(() {
      _showTerminal = !_showTerminal;
    });

    if (_showTerminal) {
      _terminalOverlay = OverlayEntry(
        builder: (context) => _buildFloatingTerminal(),
      );
      Overlay.of(context).insert(_terminalOverlay!);
    } else {
      _terminalOverlay?.remove();
      _terminalOverlay = null;
      _isTerminalMaximized = false;
    }
  }

  void _toggleTerminalMaximize() {
    setState(() {
      _isTerminalMaximized = !_isTerminalMaximized;
    });
    _terminalOverlay?.markNeedsBuild();
  }

  Widget _buildFloatingTerminal() {
    if (_isTerminalMaximized) {
      return Material(
        color: Colors.black54,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Terminal(
            isMaximized: true,
            onToggleMaximize: _toggleTerminalMaximize,
          ),
        ),
      );
    }

    return Positioned(
      right: 24,
      bottom: 24,
      child: Container(
        width: 600,
        height: 400,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Terminal(
          isMaximized: false,
          onToggleMaximize: _toggleTerminalMaximize,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        return Scaffold(
          body: Stack(
            children: [
              CustomScrollView(
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
                            ? AppTheme.backgroundColor.withValues(alpha: 0.85)
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
                                  _ThemeToggleButton(),
                                  const SizedBox(width: 16),
                                  _HoverNavButton(
                                    text: 'Terminal',
                                    onPressed: _toggleTerminal,
                                  ),
                                  const SizedBox(width: 16),
                                  _HoverNavButton(
                                    text: 'Resume',
                                    onPressed: _downloadResume,
                                  ),
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
            ],
          ),
          floatingActionButton: !_showTerminal
              ? FloatingActionButton(
                  onPressed: _toggleTerminal,
                  backgroundColor: AppTheme.primaryColor,
                  tooltip: 'Open Terminal',
                  child: const Icon(Icons.terminal, color: Colors.white),
                )
              : null,
        );
      },
    );
  }
}

class _ThemeToggleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: themeNotifier.toggleTheme,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 60,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: themeNotifier.isDarkMode
                    ? AppTheme.surfaceColor
                    : AppTheme.borderColor,
                border: Border.all(
                  color: AppTheme.borderColor,
                  width: 1,
                ),
              ),
              child: Stack(
                children: [
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    left: themeNotifier.isDarkMode ? 2 : 32,
                    top: 2,
                    child: Container(
                      width: 26,
                      height: 26,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: themeNotifier.isDarkMode
                            ? AppTheme.primaryColor
                            : Colors.orange,
                        boxShadow: [
                          BoxShadow(
                            color: (themeNotifier.isDarkMode
                                    ? AppTheme.primaryColor
                                    : Colors.orange)
                                .withOpacity(0.3),
                            blurRadius: 8,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Icon(
                        themeNotifier.isDarkMode
                            ? Icons.nightlight_round
                            : Icons.wb_sunny,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
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

class __HoverNavButtonState extends State<_HoverNavButton>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hoveredColor = AppTheme.primaryColor;
    final nonHoveredColor = AppTheme.textSecondary;

    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      cursor: SystemMouseCursors.click,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
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
        },
      ),
    );
  }

  void _onHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });
    if (isHovered) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }
}

