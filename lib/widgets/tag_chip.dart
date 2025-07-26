import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TagChip extends StatelessWidget {
  final String label;
  final IconData? icon;

  const TagChip({
    super.key,
    required this.label,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: const Color(0xFF2A2A2A)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null)
            Icon(
              icon,
              color: const Color(0xFF34D399),
              size: 14,
            ),
          if (icon != null) const SizedBox(width: 4),
          Text(
            label,
            style: GoogleFonts.inter(
              color: const Color(0xFF34D399),
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
