import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SkillChip extends StatelessWidget {
  final String label;
  final bool isSmall;

  const SkillChip({
    super.key, 
    required this.label,
    this.isSmall = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSmall ? 12 : 16, 
        vertical: isSmall ? 6 : 8
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF222222),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF333333)),
      ),
      child: Text(
        label,
        style: GoogleFonts.jetBrainsMono(
          color: Colors.white.withOpacity(0.8),
          fontSize: isSmall ? 12 : 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}