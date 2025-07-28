import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../animations/fade_animation.dart';
import '../services/data_service.dart';
import '../theme/app_theme.dart';
import 'particle_background.dart';

class PersonalInterestsSection extends StatelessWidget {
  const PersonalInterestsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final artists = DataService.getFavoriteArtists();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100),
      color: AppTheme.backgroundColor,
      child: Stack(
        children: [
          const Positioned.fill(child: ParticleBackground()),
          Container(
            constraints: const BoxConstraints(maxWidth: 1400),
            margin: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                FadeAnimation(
                  child: _buildSectionHeader(),
                ),
                const SizedBox(height: 80),
                LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth > 800) {
                      return Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: FadeAnimation(
                                  delay: const Duration(milliseconds: 200),
                                  child: _buildMusicCard(artists),
                                ),
                              ),
                              const SizedBox(width: 32),
                              Expanded(
                                child: FadeAnimation(
                                  delay: const Duration(milliseconds: 400),
                                  child: _buildChessCard(),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 80), 
                          FadeAnimation(
                            delay: const Duration(milliseconds: 600),
                            child: _buildContactButton('akshatsingh2474@gmail.com', 'mailto:akshatsingh2474@gmail.com'),
                          ),
                        ],
                      );
                    } else {
                      return Column(
                        children: [
                          FadeAnimation(
                            delay: const Duration(milliseconds: 200),
                            child: _buildMusicCard(artists),
                          ),
                          const SizedBox(height: 32),
                          FadeAnimation(
                            delay: const Duration(milliseconds: 400),
                            child: _buildChessCard(),
                          ),
                          const SizedBox(height: 80),
                          FadeAnimation(
                            delay: const Duration(milliseconds: 600),
                            child: _buildContactButton('akshatsingh2474@gmail.com', 'mailto:akshatsingh2474@gmail.com'),
                          ),
                        ],
                      );
                    }
                  },
                ),
                const SizedBox(height: 80), 
                FadeAnimation(
                  delay: const Duration(milliseconds: 600),
                  child: _buildFooter(),
                ),
              ],
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

  Widget _buildMusicCard(List<String> artists) {
    return _SimpleInterestCard(
      color: AppTheme.primaryColor,
      icon: Icons.music_note_rounded,
      title: 'Music Enthusiast',
      description:
          'Music fuels my creativity and keeps me inspired during long coding sessions. Here are some of my favorite artists.',
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        alignment: WrapAlignment.center,
        children: artists.map((artist) => _buildArtistTag(artist)).toList(),
      ),
    );
  }

  Widget _buildArtistTag(String artist) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withValues(alpha:0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.primaryColor.withValues(alpha:0.2)),
      ),
      child: Text(
        artist,
        style: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppTheme.primaryColor,
        ),
      ),
    );
  }

  Widget _buildChessCard() {
    return _SimpleInterestCard(
      color: AppTheme.accentGreen,
      icon: Icons.games_rounded,
      title: 'Chess Player',
      description:
          'I enjoy playing chess in my free time. Strategic thinking and pattern recognition make it the perfect complement to programming.',
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: _buildChessProfileButton(
              'Lichess',
              'akshat2474',
              'https://lichess.org/@/akshat2474',
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildChessProfileButton(
              'Chess.com',
              'akshat2474',
              'https://www.chess.com/member/akshat2474',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChessProfileButton(String platform, String username, String url) {
    return OutlinedButton(
      onPressed: () => _launchUrl(url),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12),
        side: BorderSide(color: AppTheme.accentGreen.withValues(alpha:0.3)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(
        platform,
        style: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppTheme.accentGreen,
        ),
      ),
    );
  }

  Widget _buildContactButton(String email, String url) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 320),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => _launchUrl(url),
            borderRadius: BorderRadius.circular(16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF9CD3D9),
                    const Color(0xFF7BC3D1),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF9CD3D9).withValues(alpha:0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                    spreadRadius: 0,
                  ),
                  BoxShadow(
                    color: Colors.black.withValues(alpha:0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha:0.3),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.white.withValues(alpha:0.4),
                        width: 1,
                      ),
                    ),
                    child: const Icon(
                      Icons.mail_outline_rounded,
                      color: Color(0xFF2D6A75),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Get in Touch',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF2D6A75),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Drop me a line',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF2D6A75).withValues(alpha:0.8),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 4,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppTheme.primaryColor, AppTheme.accentBlue],
              ),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Built with Flutter & passion',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '© 2025 Akshat Singh. All rights reserved.',
            style: GoogleFonts.inter(
              fontSize: 14,
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _SimpleInterestCard extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String title;
  final String description;
  final Widget child;

  const _SimpleInterestCard({
    required this.color,
    required this.icon,
    required this.title,
    required this.description,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor.withValues(alpha:0.8),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: color.withValues(alpha:0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: color, size: 32),
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: GoogleFonts.inter(
              fontSize: 16,
              height: 1.6,
              color: AppTheme.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          child,
        ],
      ),
    );
  }
}