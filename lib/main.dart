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
    const Color primaryTextColor = Color(0xFFEAEAEA);
    const Color secondaryTextColor = Color(0xFF8A8A8A);
    const Color backgroundColor = Color(0xFF0A0A0A);
    const Color cardBackgroundColor = Color(0xFF141414);

    return MaterialApp(
      title: 'Akshat Singh - Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: primaryTextColor,
        scaffoldBackgroundColor: backgroundColor,
        cardColor: cardBackgroundColor,
        textTheme:
            GoogleFonts.interTextTheme(ThemeData.dark().textTheme).copyWith(
          displayMedium: GoogleFonts.inter(
              fontSize: 36,
              fontWeight: FontWeight.w800,
              color: primaryTextColor),
          headlineSmall: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: secondaryTextColor,
              letterSpacing: 0.5),
          titleMedium: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: primaryTextColor),
          bodyLarge: GoogleFonts.inter(
              fontSize: 16, height: 1.6, color: secondaryTextColor),
          bodyMedium:
              GoogleFonts.inter(fontSize: 14, color: secondaryTextColor),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: primaryTextColor,
            textStyle: GoogleFonts.inter(fontWeight: FontWeight.w600),
          ),
        ),
      ),
      home: const PortfolioPage(),
    );
  }
}
