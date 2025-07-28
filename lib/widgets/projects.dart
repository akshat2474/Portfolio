import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../animations/fade_animation.dart';
import '../models/project.dart';
import '../services/data_service.dart';
import '../theme/app_theme.dart';
import 'particle_background.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final projects = DataService.getProjects();

    return Container(
      color: AppTheme.backgroundColor,
      child: Stack(
        children: [
          const Positioned.fill(child: ParticleBackground()),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 100),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 1400),
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
          ),
        ],
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
        int crossAxisCount = 1;
        double childAspectRatio = 1.4; 
        
        if (constraints.maxWidth > 1200) {
          crossAxisCount = 3;
          childAspectRatio = 0.9;
        } else if (constraints.maxWidth > 800) {
          crossAxisCount = 2;
          childAspectRatio = 1.0;
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: childAspectRatio,
            crossAxisSpacing: 24,
            mainAxisSpacing: 24,
          ),
          itemCount: projects.length,
          itemBuilder: (context, index) {
            return FadeAnimation(
              delay: Duration(milliseconds: 150 * index),
              child: _ProjectCard(project: projects[index]),
            );
          },
        );
      },
    );
  }
}

class _ProjectCard extends StatelessWidget {
  final Project project;

  const _ProjectCard({required this.project});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.surfaceColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _getStatusColor(project.name).withValues(alpha:0.2),
            width: 1.5,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCardHeader(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildCardContent(),
                      const Spacer(),
                      _buildCardFooter(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardHeader() {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: _getStatusColor(project.name).withValues(alpha:0.1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: _getStatusColor(project.name).withValues(alpha:0.2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                _getProjectIcon(project.name),
                color: _getStatusColor(project.name),
                size: 32,
              ),
            ),
            _buildCategoryTag(),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryTag() {
    final color = _getStatusColor(project.name);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha:0.9),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha:0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            _getProjectCategory(project.name),
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(
          project.name,
          style: GoogleFonts.inter(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimary,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 12),
        Text(
          project.overview,
          style: GoogleFonts.inter(
            fontSize: 15,
            height: 1.6,
            color: AppTheme.textSecondary,
          ),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: project.technologies.take(3).map((tech) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: _getStatusColor(project.name).withValues(alpha:.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _getStatusColor(project.name).withValues(alpha:0.2),
              ),
            ),
            child: Text(
              tech,
              style: GoogleFonts.inter(
                color: _getStatusColor(project.name),
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          )).toList(),
        ),
      ],
    );
  }

  Widget _buildCardFooter() {
    return Column(
      children: [
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
              if (project.githubUrl != null) const SizedBox(width: 12),
            ],
            if (project.githubUrl != null)
              Expanded(
                child: _buildActionButton(
                  'View Code',
                  Icons.code_rounded,
                  () => _launchUrl(project.githubUrl!),
                  false,
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton(String text, IconData icon, VoidCallback onPressed, bool isPrimary) {
    final color = _getStatusColor(project.name);
    
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: isPrimary ? color : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: isPrimary ? null : Border.all(color: AppTheme.borderColor),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 16,
                color: isPrimary ? Colors.white : AppTheme.textSecondary,
              ),
              const SizedBox(width: 8),
              Text(
                text,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isPrimary ? Colors.white : AppTheme.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
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