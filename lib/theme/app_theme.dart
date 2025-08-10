import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Dark Theme Colors
  static const Color darkPrimaryColor = Color(0xFF8B5CF6);
  static const Color darkBackgroundColor = Color(0xFF0A0A0A);
  static const Color darkSurfaceColor = Color(0xFF1A1A1A);
  static const Color darkBorderColor = Color(0xFF2A2A2A);
  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFFB3B3B3);
  static const Color darkTextMuted = Color(0xFF666666);
  
  // Light Theme Colors
  static const Color lightPrimaryColor = Color(0xFF8B5CF6);
  static const Color lightBackgroundColor = Color(0xFFF8FAFC);
  static const Color lightSurfaceColor = Color(0xFFFFFFFF);
  static const Color lightBorderColor = Color(0xFFE2E8F0);
  static const Color lightTextPrimary = Color(0xFF1E293B);
  static const Color lightTextSecondary = Color(0xFF64748B);
  static const Color lightTextMuted = Color(0xFF94A3B8);
  
  // Common Colors
  static const Color accentBlue = Color(0xFF3B82F6);
  static const Color accentGreen = Color(0xFF10B981);
  static const Color accentRed = Color(0xFFEF4444);

  // Current theme colors (will be updated by ThemeNotifier)
  static Color primaryColor = darkPrimaryColor;
  static Color backgroundColor = darkBackgroundColor;
  static Color surfaceColor = darkSurfaceColor;
  static Color borderColor = darkBorderColor;
  static Color textPrimary = darkTextPrimary;
  static Color textSecondary = darkTextSecondary;
  static Color textMuted = darkTextMuted;

  static void updateTheme(bool isDark) {
    if (isDark) {
      primaryColor = darkPrimaryColor;
      backgroundColor = darkBackgroundColor;
      surfaceColor = darkSurfaceColor;
      borderColor = darkBorderColor;
      textPrimary = darkTextPrimary;
      textSecondary = darkTextSecondary;
      textMuted = darkTextMuted;
    } else {
      primaryColor = lightPrimaryColor;
      backgroundColor = lightBackgroundColor;
      surfaceColor = lightSurfaceColor;
      borderColor = lightBorderColor;
      textPrimary = lightTextPrimary;
      textSecondary = lightTextSecondary;
      textMuted = lightTextMuted;
    }
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      primaryColor: darkPrimaryColor,
      scaffoldBackgroundColor: darkBackgroundColor,
      textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
      colorScheme: const ColorScheme.dark(
        primary: darkPrimaryColor,
        surface: darkSurfaceColor,
        background: darkBackgroundColor,
        onSurface: darkTextPrimary,
      ),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      primaryColor: lightPrimaryColor,
      scaffoldBackgroundColor: lightBackgroundColor,
      textTheme: GoogleFonts.interTextTheme(ThemeData.light().textTheme),
      colorScheme: const ColorScheme.light(
        primary: lightPrimaryColor,
        surface: lightSurfaceColor,
        background: lightBackgroundColor,
        onSurface: lightTextPrimary,
      ),
    );
  }
}
