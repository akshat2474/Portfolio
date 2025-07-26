import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/project_model.dart';

class ProjectCard extends StatelessWidget {
  final Project project;

  const ProjectCard({
    super.key,
    required this.project,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF222222)),
        borderRadius: BorderRadius.circular(16),
        color: const Color(0xFF0A0A0A).withOpacity(0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(project.title, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          Text(
            project.description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.6),
          ),
          const SizedBox(height: 16),
          Text(
            'Tech Stack: ${project.techStack}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white70,
              fontStyle: FontStyle.italic,
            )
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Conditionally add the "Live Demo" button if a URL exists
              if (project.liveUrl != null)
                FilledButton.icon(
                  icon: const Icon(Icons.open_in_new, size: 16),
                  label: const Text('Live Demo'),
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    visualDensity: VisualDensity.compact,
                  ),
                  onPressed: () {
                    launchUrl(Uri.parse(project.liveUrl!));
                  },
                ),

              if (project.liveUrl != null)
                const SizedBox(width: 12),

              TextButton(
                onPressed: () => _showDetailsDialog(context, project),
                child: const Text(
                  'View Details →',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showDetailsDialog(BuildContext context, Project project) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1A1A1A),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: Color(0xFF333333)),
          ),
          title: Text(project.title, style: Theme.of(context).textTheme.headlineMedium),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                _buildDetailSection('Core Features', project.coreFeatures, context, isList: true),
                _buildDetailSection('Notable Implementation', [project.implementationDetails], context),
                _buildDetailSection('Gaps / Next Steps', [project.gaps], context),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildDetailSection(String title, List<String> items, BuildContext context, {bool isList = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 8),
          ...items.map((item) => Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isList) ...[
                  const Text('• ', style: TextStyle(color: Colors.white70, fontSize: 16)),
                ] ,
                Expanded(
                  child: Text(
                    item,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white70),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}