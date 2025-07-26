class Project {
  final String title;
  final String description;
  final List<String> coreFeatures;
  final String techStack;
  final String implementationDetails;
  final String gaps;
  final String? liveUrl; 

  const Project({
    required this.title,
    required this.description,
    required this.coreFeatures,
    required this.techStack,
    required this.implementationDetails,
    required this.gaps,
    this.liveUrl,
  });
}