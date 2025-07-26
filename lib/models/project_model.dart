import 'package:flutter/widgets.dart';

class Project {
  final String title;
  final String description;
  final List<String> coreFeatures;
  final String techStack;
  final String implementationDetails;
  final String gaps;
  final String? liveUrl;
  final IconData icon; 
  final int year;
  final List<String> tags;

  const Project({
    required this.title,
    required this.description,
    required this.coreFeatures,
    required this.techStack,
    required this.implementationDetails,
    required this.gaps,
    required this.year,
    required this.tags,
    required this.icon, 
    this.liveUrl,
  });
}
