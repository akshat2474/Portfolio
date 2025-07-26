import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'portfolio_page.dart';

// Define your new accent color
const Color accentColor = Color(0xFF89CFF0);

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
        
        // Use Montserrat as the primary font
        textTheme: GoogleFonts.montserratTextTheme(ThemeData.dark().textTheme).copyWith(
          displayLarge: GoogleFonts.montserrat(
            fontSize: 48,
            fontWeight: FontWeight.w900, // Bolder to match your README
            letterSpacing: -0.04,
            color: primaryTextColor,
          ),
          headlineMedium: GoogleFonts.montserrat(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: primaryTextColor,
          ),
          bodyLarge: GoogleFonts.montserrat(
            fontSize: 16,
            height: 1.7,
            color: secondaryTextColor,
          ),
          bodyMedium: GoogleFonts.montserrat(
            fontSize: 14,
            color: secondaryTextColor,
          ),
          titleMedium: GoogleFonts.montserrat(
            fontSize: 18, // Slightly larger for project titles
            fontWeight: FontWeight.w700,
            color: primaryTextColor,
          ),
        ),
        
        iconTheme: const IconThemeData(color: primaryTextColor, size: 28),
      ),
      home: const PortfolioPage(),
    );
  }
}