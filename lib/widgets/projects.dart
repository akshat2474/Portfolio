import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../animations/fade_animation.dart';
import '../models/project.dart';
import '../services/data_service.dart';
import '../theme/app_theme.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final projects = DataService.getProjects();
    
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100),
      color: AppTheme.backgroundColor,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1200),
        margin: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            FadeAnimation(
              child: _buildSectionHeader(),
            ),
            const SizedBox(height: 80),
            _buildProjectsGrid(projects),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppTheme.surfaceColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppTheme.borderColor),
          ),
          child: Text(
            'PROJECTS',
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppTheme.primaryColor,
              letterSpacing: 1,
            ),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Featured Work',
          style: GoogleFonts.inter(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'A collection of projects I\'ve worked on',
          style: GoogleFonts.inter(
            fontSize: 16,
            color: AppTheme.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildProjectsGrid(List<Project> projects) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount;
        double childAspectRatio;
        
        if (constraints.maxWidth > 1000) {
          crossAxisCount = 2;
          childAspectRatio = 1.2;
        } else if (constraints.maxWidth > 600) {
          crossAxisCount = 2;
          childAspectRatio = 1.0;
        } else {
          crossAxisCount = 1;
          childAspectRatio = 1.1;
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 24,
            mainAxisSpacing: 24,
            childAspectRatio: childAspectRatio,
          ),
          itemCount: projects.length,
          itemBuilder: (context, index) {
            return FadeAnimation(
              delay: Duration(milliseconds: 200 * index),
              child: _buildProjectCard(projects[index], index),
            );
          },
        );
      },
    );
  }

  Widget _buildProjectCard(Project project, int index) {
  return Container(
    decoration: BoxDecoration(
      color: AppTheme.surfaceColor,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: AppTheme.borderColor),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withValues(alpha:0.05),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withValues(alpha:0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    _getProjectIcon(project.name),
                    color: AppTheme.primaryColor,
                    size: 40,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _getStatusColor(project.name).withValues(alpha:0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: _getStatusColor(project.name).withValues(alpha:0.3),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: _getStatusColor(project.name),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        _getProjectCategory(project.name),
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: _getStatusColor(project.name),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  project.name,
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                
                Expanded(
                  child: Text(
                    project.overview,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      height: 1.5,
                      color: AppTheme.textSecondary,
                    ),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                
                const SizedBox(height: 20),
                
                Row(
                  children: [
                    if (project.liveUrl != null) ...[
                      Expanded(
                        child: _buildActionButton(
                          'Live Demo',
                          Icons.launch_rounded,
                          () => _launchUrl(project.liveUrl!),
                          true,
                        ),
                      ),
                      if (project.githubUrl != null) const SizedBox(width: 8),
                    ],
                    if (project.githubUrl != null)
                      Expanded(
                        child: _buildActionButton(
                          'Code',
                          Icons.code_rounded,
                          () => _launchUrl(project.githubUrl!),
                          false,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Color _getStatusColor(String projectName) {
  switch (projectName.toLowerCase()) {
    case 'carboneye':
      return AppTheme.accentGreen;
    case 'color harmony':
      return AppTheme.primaryColor;
    case 'retrodash':
      return AppTheme.accentRed;
    case 'hand2hand':
      return AppTheme.accentBlue;
    case 'timewise':
      return AppTheme.primaryColor;
    case 'trainos':
      return AppTheme.accentGreen;
    default:
      return AppTheme.primaryColor;
  }
}

String _getProjectCategory(String projectName) {
  switch (projectName.toLowerCase()) {
    case 'carboneye':
      return 'Environmental';
    case 'color harmony':
      return 'Design Tool';
    case 'retrodash':
      return 'Game';
    case 'hand2hand':
      return 'Social Impact';
    case 'timewise':
      return 'Productivity';
    case 'trainos':
      return 'Health & Fitness';
    default:
      return 'Web App';
  }
}


  Widget _buildActionButton(String text, IconData icon, VoidCallback onPressed, bool isPrimary) {
    return Container(
      height: 36,
      decoration: BoxDecoration(
        color: isPrimary ? AppTheme.primaryColor : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: isPrimary ? null : Border.all(color: AppTheme.borderColor),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 14,
                color: isPrimary ? Colors.white : AppTheme.textSecondary,
              ),
              const SizedBox(width: 6),
              Text(
                text,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: isPrimary ? Colors.white : AppTheme.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getProjectIcon(String projectName) {
    switch (projectName.toLowerCase()) {
      case 'carboneye':
        return Icons.visibility_rounded;
      case 'color harmony':
        return Icons.palette_rounded;
      case 'retrodash':
        return Icons.games_rounded;
      case 'hand2hand':
        return Icons.volunteer_activism_rounded;
      case 'timewise':
        return Icons.schedule_rounded;
      case 'trainos':
        return Icons.fitness_center_rounded;
      default:
        return Icons.web_rounded;
    }
  }

  void _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}
