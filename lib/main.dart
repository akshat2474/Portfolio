import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'portfolio_page.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryTextColor = Colors.white;
    const Color secondaryTextColor = Color(0xFFAAAAAA);
    const Color backgroundColor = Colors.black;

    return MaterialApp(
      title: 'Akshat Singh - Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: primaryTextColor,
        scaffoldBackgroundColor: backgroundColor,
        textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme).copyWith(
          displayLarge: GoogleFonts.inter(
            fontSize: 48,
            fontWeight: FontWeight.w800,
            color: primaryTextColor,
          ),
          headlineMedium: GoogleFonts.inter(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: primaryTextColor,
          ),
          bodyLarge: GoogleFonts.inter(
            fontSize: 16,
            height: 1.7,
            color: secondaryTextColor,
          ),
          titleMedium: GoogleFonts.jetBrainsMono(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: primaryTextColor,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryTextColor,
            foregroundColor: backgroundColor,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      home: const PortfolioPage(),
    );
  }
}