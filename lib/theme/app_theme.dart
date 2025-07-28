import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Modern dark theme colors matching the design
  static const Color primaryColor = Color(0xFF8B5CF6); 
  static const Color backgroundColor = Color(0xFF0A0A0A); 
  static const Color surfaceColor = Color(0xFF1A1A1A); 
  static const Color borderColor = Color(0xFF2A2A2A);
  
  // Text colors
  static const Color textPrimary = Color(0xFFFFFFFF); 
  static const Color textSecondary = Color(0xFFB3B3B3); 
  static const Color textMuted = Color(0xFF666666); 
  
  // Accent colors
  static const Color accentBlue = Color(0xFF3B82F6); 
  static const Color accentGreen = Color(0xFF10B981); 
  static const Color accentRed = Color(0xFFEF4444); 

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
      colorScheme: const ColorScheme.dark(
        primary: primaryColor,
        surface: surfaceColor,
        background: backgroundColor,
        onSurface: textPrimary,
      ),
    );
  }
}
