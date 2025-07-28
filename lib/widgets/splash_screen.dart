import 'dart:async';
import 'package:akshat_portfolio/widgets/particle_background.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../main.dart';
import '../theme/app_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _progressController;
  late AnimationController _textController;

  int _currentIndex = 0;
  Timer? _textTimer;

  final List<String> greetings = [
    'Hello',
    'Namaste',
    'Hola',
    'Bonjour',
    'Ciao',
    'こんにちは',
  ];

  @override
  void initState() {
    super.initState();

    _progressController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();

    _textController = AnimationController(
      duration: const Duration(milliseconds: 150), 
      vsync: this,
    );

    _startTextAnimation();

    Timer(
      const Duration(seconds: 2),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PortfolioHome()),
      ),
    );
  }

  void _startTextAnimation() {
    _textController.forward().then((_) {
      Timer(const Duration(milliseconds: 120), () {
        if (mounted) {
          _textController.reverse().then((_) {
            if (mounted) {
              setState(() {
                _currentIndex = (_currentIndex + 1) % greetings.length;
              });
              _startTextAnimation();
            }
          });
        }
      });
    });
  }

  @override
  void dispose() {
    _progressController.dispose();
    _textController.dispose();
    _textTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Stack(
        children: [
          const Positioned.fill(child: ParticleBackground()),
          Center(
            child: Container(
              height: 100, 
              alignment: Alignment.center,
              child: AnimatedBuilder(
                animation: _textController,
                builder: (context, child) {
                  return Opacity(
                    opacity: Curves.easeInOut.transform(_textController.value), 
                    child: Transform.translate(
                      offset: Offset(0, Curves.easeOutBack.transform(1 - _textController.value) * 15), 
                      child: Text(
                        greetings[_currentIndex],
                        style: GoogleFonts.inter(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textPrimary,
                          letterSpacing: -1,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 60,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Loading',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: AppTheme.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      AnimatedBuilder(
                        animation: _progressController,
                        builder: (context, child) {
                          return Text(
                            '${(Curves.easeInOut.transform(_progressController.value) * 100).toInt()}%', 
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: AppTheme.textSecondary,
                              fontWeight: FontWeight.w500,
                            ),
                          );
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  Container(
                    height: 1,
                    decoration: BoxDecoration(
                      color: AppTheme.textSecondary.withValues(alpha: .2),
                      borderRadius: BorderRadius.circular(0.5),
                    ),
                    child: AnimatedBuilder(
                      animation: _progressController,
                      builder: (context, child) {
                        return FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: Curves.easeInOut.transform(_progressController.value),  
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppTheme.primaryColor,
                              borderRadius: BorderRadius.circular(0.5),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}