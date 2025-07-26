import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'skill_chip.dart';

// ... imports
class ProjectCard extends StatelessWidget {
  final String title;
  final String description;
  final String techStack; // Changed from List<String>

  const ProjectCard({
    super.key,
    required this.title,
    required this.description,
    required this.techStack, // Changed
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF222222)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.6),
          ),
           const SizedBox(height: 16),
          // Display tech stack as a simple string
          Text(
            'Tech: $techStack',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white70
            )
          )
        ],
      ),
    );
  }
}