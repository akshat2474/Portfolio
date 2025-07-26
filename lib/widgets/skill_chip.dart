import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SkillChip extends StatelessWidget {
  final String label;

  const SkillChip({
    super.key, 
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF222222),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF333333)),
      ),
      child: Text(
        label,
        style: GoogleFonts.jetBrainsMono(
          color: Colors.white.withValues(alpha:0.8),
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}