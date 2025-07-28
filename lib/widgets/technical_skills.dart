import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../animations/fade_animation.dart';
import '../animations/slide_animation.dart';
import '../services/data_service.dart';
import '../theme/app_theme.dart';

class TechnicalSkillsSection extends StatelessWidget {
  const TechnicalSkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final technologies = DataService.getTechnologies();
    
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
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 24,
                mainAxisSpacing: 24,
                childAspectRatio: 1,
              ),
              itemCount: technologies.length,
              itemBuilder: (context, index) {
                return SlideAnimation(
                  delay: Duration(milliseconds: 100 * index),
                  beginOffset: const Offset(0, 0.3),
                  child: _buildSkillCard(technologies[index], index),
                );
              },
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

  Widget _buildSkillCard(String technology, int index) {
    final colors = [
      AppTheme.primaryColor,
      AppTheme.accentBlue,
      AppTheme.accentGreen,
      AppTheme.accentRed,
    ];
    final color = colors[index % colors.length];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: _getSkillIcon(technology, color),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            technology,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _getSkillIcon(String technology, Color color) {
    final iconPath = 'assets/svg/${technology.toLowerCase()}.svg';
    
    return SvgPicture.asset(
      iconPath,
      width: 24,
      height: 24,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      placeholderBuilder: (context) => Icon(
        Icons.code_rounded,
        size: 24,
        color: color,
      ),
    );
  }
}
