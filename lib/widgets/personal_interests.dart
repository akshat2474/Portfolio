import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../animations/fade_animation.dart';
import '../services/data_service.dart';
import '../theme/app_theme.dart';

class PersonalInterestsSection extends StatelessWidget {
  const PersonalInterestsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final artists = DataService.getFavoriteArtists();
    
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
            FadeAnimation(
              delay: const Duration(milliseconds: 400),
              child: _buildInterestsCard(artists),
            ),
            const SizedBox(height: 100),
            FadeAnimation(
              delay: const Duration(milliseconds: 600),
              child: _buildFooter(),
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
            'INTERESTS',
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
          'Beyond Code',
          style: GoogleFonts.inter(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'What I enjoy when I\'m not developing',
          style: GoogleFonts.inter(
            fontSize: 16,
            color: AppTheme.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildInterestsCard(List<String> artists) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              Icons.music_note_rounded,
              color: AppTheme.primaryColor,
              size: 40,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Music Enthusiast',
            style: GoogleFonts.inter(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Text(
              'Music fuels my creativity and keeps me inspired during long coding sessions. Here are some of my favorite artists that provide the perfect soundtrack to my development work.',
              style: GoogleFonts.inter(
                fontSize: 16,
                height: 1.6,
                color: AppTheme.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 32),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: artists.map((artist) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppTheme.primaryColor.withOpacity(0.2)),
              ),
              child: Text(
                artist,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.primaryColor,
                ),
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Column(
      children: [
        Container(
          width: 100,
          height: 1,
          color: AppTheme.borderColor,
        ),
        const SizedBox(height: 32),
        Text(
          'Built with Flutter & passion',
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppTheme.textSecondary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '© 2025 Akshat Singh. All rights reserved.',
          style: GoogleFonts.inter(
            fontSize: 14,
            color: AppTheme.textMuted,
          ),
        ),
      ],
    );
  }
}
