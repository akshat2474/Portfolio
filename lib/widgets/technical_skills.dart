import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../animations/fade_animation.dart';
import '../services/data_service.dart';
import '../theme/app_theme.dart';

class Skill {
  final String name;
  final String iconPath;

  Skill({required this.name, required this.iconPath});
}

class TechnicalSkillsSection extends StatelessWidget {
  const TechnicalSkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final categorizedSkills = DataService.getCategorizedSkills();
    final categories = categorizedSkills.keys.toList();

    return Container(
      color: AppTheme.backgroundColor, 
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 100),
        constraints: const BoxConstraints(maxWidth: 1200),
        margin: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            FadeAnimation(
              child: _buildSectionHeader(),
            ),
            const SizedBox(height: 80),
            FadeAnimation(
              delay: const Duration(milliseconds: 200),
              // PERFORMANCE FIX: Replaced the expensive BackdropFilter with a simple Container.
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 40),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceColor.withValues(alpha:0.5), // Simple transparency is much faster.
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppTheme.borderColor.withValues(alpha:0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(categories.length, (index) {
                    final category = categories[index];
                    final skills = categorizedSkills[category]!;
                    return Expanded(
                      child: FadeAnimation(
                        delay: Duration(milliseconds: 200 * (index + 1)),
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: index < categories.length - 1 ? 40 : 0,
                          ),
                          child: _buildSkillColumn(category, skills, index),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
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
            'SKILLS',
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
          'Technical Expertise',
          style: GoogleFonts.inter(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimary, 
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Technologies I use to bring ideas to life',
          style: GoogleFonts.inter(
            fontSize: 16,
            color: AppTheme.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildSkillColumn(String title, List<Skill> skills, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: AppTheme.primaryColor.withValues(alpha:0.3),
                width: 2,
              ),
            ),
          ),
          child: Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary, 
            ),
          ),
        ),
        const SizedBox(height: 24),
        ...skills.map((skill) => _buildSkillItem(skill)),
      ],
    );
  }

  Color _getSkillColor(String skillName) {
    switch (skillName.toLowerCase()) {
      case 'flutter':
      case 'dart':
        return Colors.lightBlue[400]!;
      case 'python':
        return Colors.yellow[700]!;
      case 'c++':
        return Colors.indigo[400]!;
      case 'pytorch':
      case 'tensorflow':
        return Colors.orange[600]!;
      case 'scikit-learn':
        return Colors.teal[300]!;
      case 'firebase':
        return Colors.amber[500]!;
      case 'git':
        return Colors.red[600]!;
      case 'canva':
        return Colors.purpleAccent[100]!;
      default:
        return AppTheme.primaryColor;
    }
  }

  Widget _buildSkillItem(Skill skill) {
    final color = _getSkillColor(skill.name);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppTheme.backgroundColor.withValues(alpha:.5),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppTheme.borderColor.withValues(alpha:0.2),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: color.withValues(alpha:0.2),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: SvgPicture.asset(
                  skill.iconPath,
                  width: 18,
                  height: 18,
                  colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                  placeholderBuilder: (context) => Icon(
                    Icons.code_rounded,
                    size: 18,
                    color: color,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                skill.name,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.textSecondary, 
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
