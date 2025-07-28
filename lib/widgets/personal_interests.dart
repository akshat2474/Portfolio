import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
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
                // Responsive layout
                if (constraints.maxWidth > 800) {
                  return Row(
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
                    ],
                  );
                }
              },
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

  Widget _buildMusicCard(List<String> artists) {
    return _InterestCard(
      color: AppTheme.primaryColor,
      icon: Icons.music_note_rounded,
      title: 'Music Enthusiast',
      description: 'Music fuels my creativity and keeps me inspired during long coding sessions. Here are some of my favorite artists.',
      child: Column(
        children: [
          const SizedBox(height: 24),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: artists.map((artist) => _buildArtistTag(artist)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildArtistTag(String artist) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.primaryColor.withValues(alpha:0.1),
            AppTheme.primaryColor.withValues(alpha:0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.primaryColor.withValues(alpha:0.2)),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withValues(alpha:0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
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
    return _InterestCard(
      color: AppTheme.accentGreen,
      icon: Icons.games_rounded,
      title: 'Chess Player',
      description: 'I enjoy playing chess in my free time. Strategic thinking and pattern recognition make it the perfect complement to programming.',
      child: Column(
        children: [
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: _buildChessProfileButton(
                  'Lichess',
                  'akshat2474',
                  'https://lichess.org/@/akshat2474',
                  Icons.psychology_rounded,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildChessProfileButton(
                  'Chess.com',
                  'akshat2474',
                  'https://www.chess.com/member/akshat2474',
                  Icons.sports_esports_rounded,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChessProfileButton(String platform, String username, String url, IconData icon) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.accentGreen.withValues(alpha:0.1),
            AppTheme.accentGreen.withValues(alpha:0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.accentGreen.withValues(alpha:0.2)),
        boxShadow: [
          BoxShadow(
            color: AppTheme.accentGreen.withValues(alpha:0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _launchUrl(url),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: AppTheme.accentGreen,
                  size: 20,
                ),
                const SizedBox(height: 4),
                Text(
                  platform,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.accentGreen,
                  ),
                ),
              ],
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
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.surfaceColor.withValues(alpha:0.5),
            AppTheme.surfaceColor.withValues(alpha:0.2),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.borderColor.withValues(alpha:0.5)),
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

class _InterestCard extends StatefulWidget {
  final Color color;
  final IconData icon;
  final String title;
  final String description;
  final Widget child;

  const _InterestCard({
    required this.color,
    required this.icon,
    required this.title,
    required this.description,
    required this.child,
  });

  @override
  __InterestCardState createState() => __InterestCardState();
}

class __InterestCardState extends State<_InterestCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.02).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _glowAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        _animationController.forward();
      },
      onExit: (_) {
        _animationController.reverse();
      },
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: widget.color.withValues(alpha:0.1 + (_glowAnimation.value * 0.2)),
                    blurRadius: 20 + (_glowAnimation.value * 10),
                    offset: const Offset(0, 10),
                    spreadRadius: _glowAnimation.value * 2,
                  ),
                  BoxShadow(
                    color: Colors.black.withValues(alpha:0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      widget.color.withValues(alpha:0.05),
                      AppTheme.surfaceColor,
                      AppTheme.surfaceColor,
                    ],
                    stops: const [0.0, 0.3, 1.0],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: widget.color.withValues(alpha:0.1 + (_glowAnimation.value * 0.2)),
                    width: 1 + (_glowAnimation.value * 0.5),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Column(
                    children: [
                      _buildCardHeader(),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40, 0, 40, 40),
                        child: Column(
                          children: [
                            _buildCardContent(),
                            widget.child,
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCardHeader() {
    return Container(
      height: 140,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            widget.color.withValues(alpha:0.2),
            widget.color.withValues(alpha:0.05),
          ],
        ),
      ),
      child: Center(
        child: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: widget.color.withValues(alpha:0.2),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: widget.color.withValues(alpha:0.3),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Icon(
            widget.icon,
            color: widget.color,
            size: 40,
          ),
        ),
      ),
    );
  }

  Widget _buildCardContent() {
    return Column(
      children: [
        const SizedBox(height: 32),
        Text(
          widget.title,
          style: GoogleFonts.inter(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimary,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Text(
            widget.description,
            style: GoogleFonts.inter(
              fontSize: 16,
              height: 1.6,
              color: AppTheme.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
