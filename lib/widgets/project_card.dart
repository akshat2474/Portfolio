import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/project_model.dart';

class ProjectCard extends StatefulWidget {
  final Project project;

  const ProjectCard({super.key, required this.project});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          if (widget.project.liveUrl != null) {
            launchUrl(Uri.parse(widget.project.liveUrl!));
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 280,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _isHovered ? Colors.white38 : const Color(0xFF2A2A2A),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                widget.project.icon,
                size: 40,
                color: _isHovered ? Colors.white : Colors.white70,
              ),
              const Spacer(),
              Text(widget.project.title,
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 4),
              Text(
                widget.project.description,
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  ...widget.project.tags.map((tag) => Text(
                        '$tag • ',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Colors.white70, fontSize: 12),
                      )),
                  Text(
                    widget.project.year.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
