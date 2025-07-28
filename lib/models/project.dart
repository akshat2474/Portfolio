class Project {
  final String name;
  final String overview;
  final List<String> keyFeatures;
  final String technicalDetails;
  final String? liveUrl;
  final String? githubUrl;
  final String iconPath;
  final List<String> technologies;

  Project({
    required this.name,
    required this.overview,
    required this.keyFeatures,
    required this.technicalDetails,
    this.liveUrl,
    this.githubUrl,
    required this.iconPath,
    required this.technologies,
  });
}
