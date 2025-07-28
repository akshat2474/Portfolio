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
    final isSmallScreen = MediaQuery.of(context).size.width < 800;

    return Container(
      color: AppTheme.backgroundColor,
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 24),
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              FadeAnimation(
                child: _buildSectionHeader(isSmallScreen),
              ),
              const SizedBox(height: 80),
              FadeAnimation(
                delay: const Duration(milliseconds: 200),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 50,
                    horizontal: isSmallScreen ? 24 : 40,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceColor.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppTheme.borderColor.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  // Use LayoutBuilder to create a responsive layout
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth < 800) {
                        // For smaller screens, use a Column to stack categories
                        return Column(
                          children:
                              List.generate(categories.length, (index) {
                            final category = categories[index];
                            final skills = categorizedSkills[category]!;
                            return Padding(
                              padding: EdgeInsets.only(
                                bottom: index < categories.length - 1 ? 40 : 0,
                              ),
                              child: _buildSkillColumn(category, skills),
                            );
                          }),
                        );
                      } else {
                        // For larger screens, use a Row
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:
                              List.generate(categories.length, (index) {
                            final category = categories[index];
                            final skills = categorizedSkills[category]!;
                            return Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                  right:
                                      index < categories.length - 1 ? 40 : 0,
                                ),
                                child: _buildSkillColumn(category, skills),
                              ),
                            );
                          }),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(bool isSmallScreen) {
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
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: isSmallScreen ? 36 : 48, // Adjust font size for mobile
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Technologies I use to bring ideas to life',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 16,
            color: AppTheme.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildSkillColumn(String title, List<Skill> skills) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: AppTheme.primaryColor.withOpacity(0.3),
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
          color: AppTheme.backgroundColor.withOpacity(.5),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppTheme.borderColor.withOpacity(0.2),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
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
