import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'widgets/project_card.dart';
import 'widgets/section_title.dart';
import 'widgets/background_painter.dart';

class PortfolioPage extends StatelessWidget {
  const PortfolioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(painter: BackgroundPainter()),
          ),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                children: [
                  const SizedBox(height: 80),
                  _buildHeroSection(context),
                  const SizedBox(height: 80),
                  
                  // About Me
                  const SectionTitle(title: 'About Me'),
                  Text(
                    "I'm a passionate developer and student from India with a strong interest in mobile development using Flutter and exploring the world of Python and Machine Learning. I love building useful tools, solving complex problems, and continuously learning new technologies.",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 80),

                  // Tech Stack
                  const SectionTitle(title: 'My Tech Stack'),
                  _buildTechStack(),
                  const SizedBox(height: 80),

                  // Projects
                  const SectionTitle(title: 'My Projects'),
                  _buildProjectsGrid(context),
                  const SizedBox(height: 80),

                  // GitHub Stats
                  const SectionTitle(title: 'GitHub Stats & Activity'),
                  _buildStatsSection(),
                  const SizedBox(height: 80),

                  // Contact
                  const SectionTitle(title: 'Connect With Me'),
                  _buildConnectSection(),
                  const SizedBox(height: 80),

                   // Footer
                  _buildFooter(),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return Column(
      children: [
        Text(
          "Hello, I'm Akshat",
          style: Theme.of(context).textTheme.displayLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        // Animated typing SVG from your README
        SvgPicture.network(
          'https://readme-typing-svg.herokuapp.com?font=Montserrat&weight=700&size=28&color=89CFF0&center=true&vCenter=true&width=435&lines=Developer;Student;Tech+Enthusiast',
          height: 40,
        ),
      ],
    );
  }

  Widget _buildTechStack() {
    // List of badge URLs from your README
    final List<String> badgeUrls = [
      'https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white',
      'https://img.shields.io/badge/python-3670A0?style=for-the-badge&logo=python&logoColor=ffdd54',
      'https://img.shields.io/badge/c-%2300599C.svg?style=for-the-badge&logo=c&logoColor=white',
      'https://img.shields.io/badge/firebase-a08021?style=for-the-badge&logo=firebase&logoColor=ffcd34',
      'https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white',
      'https://img.shields.io/badge/Canva-%2300C4CC.svg?style=for-the-badge&logo=Canva&logoColor=white',
      'https://img.shields.io/badge/figma-%23F24E1E.svg?style=for-the-badge&logo=figma&logoColor=white',
      'https://img.shields.io/badge/numpy-%23013243.svg?style=for-the-badge&logo=numpy&logoColor=white',
      'https://img.shields.io/badge/pandas-%23150458.svg?style=for-the-badge&logo=pandas&logoColor=white',
      'https://img.shields.io/badge/PyTorch-%23EE4C2C.svg?style=for-the-badge&logo=PyTorch&logoColor=white',
      'https://img.shields.io/badge/scikit--learn-%23F7931E.svg?style=for-the-badge&logo=scikit-learn&logoColor=white',
      'https://img.shields.io/badge/Matplotlib-%23ffffff.svg?style=for-the-badge&logo=Matplotlib&logoColor=black',
      'https://img.shields.io/badge/TensorFlow-%23FF6F00.svg?style=for-the-badge&logo=TensorFlow&logoColor=white',
      'https://img.shields.io/badge/Keras-%23D00000.svg?style=for-the-badge&logo=Keras&logoColor=white',
    ];
    
    return Center(
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        alignment: WrapAlignment.center,
        children: badgeUrls.map((url) => Image.network(url, height: 35)).toList(),
      ),
    );
  }
  
  Widget _buildProjectsGrid(BuildContext context) {
    // This template remains useful for you to fill in!
    return Column(
      children: [
        Text(
          "Here are a few projects I've worked on. (You can update these!)",
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        const ProjectCard(
          title: 'Your Flutter Project',
          description: 'A brief, one-sentence description of what this project does and the problem it solves.',
          techStack: 'Flutter, Firebase, BLoC',
        ),
      ],
    );
  }

  Widget _buildStatsSection() {
    return Center(
      child: Column(
        children: [
          // This is a PNG, so Image.network() is correct.
          // The CanvasKit renderer will fix the CORS error for it.
          Image.network(
            'https://nirzak-streak-stats.vercel.app/?user=akshat2474&theme=tokyonight-duo&hide_border=true&border_radius=2'
          ),
          
          const SizedBox(height: 16),
          
          // This is an SVG, so you MUST use SvgPicture.network().
          SvgPicture.network(
            'https://raw.githubusercontent.com/akshat2474/akshat2474/output/snake-cool.svg'
          ),
        ],
      ),
    );
  }

  Widget _buildConnectSection() {
    // Helper function for launching URLs
    void _launchURL(String url) async {
      if (!await launchUrl(Uri.parse(url))) {
        throw 'Could not launch $url';
      }
    }
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Tooltip(
          message: 'LinkedIn',
          child: IconButton(
            icon: const FaIcon(FontAwesomeIcons.linkedin),
            onPressed: () => _launchURL('https://www.linkedin.com/in/akshat-singh-48a03b312/'),
            iconSize: 32,
            splashRadius: 28,
          ),
        ),
        const SizedBox(width: 24),
        Tooltip(
          message: 'GitHub',
          child: IconButton(
            icon: const FaIcon(FontAwesomeIcons.github),
            onPressed: () => _launchURL('https://github.com/akshat2474'),
            iconSize: 32,
            splashRadius: 28,
          ),
        ),
        const SizedBox(width: 24),
        Tooltip(
          message: 'Email Me',
          child: IconButton(
            icon: const FaIcon(FontAwesomeIcons.solidEnvelope),
            onPressed: () => _launchURL('mailto:your-email@example.com'), // Replace with your email
            iconSize: 32,
            splashRadius: 28,
          ),
        ),
      ],
    );
  }

   Widget _buildFooter() {
    return Center(
      child: Column(
        children: [
          SvgPicture.network(
            'https://raw.githubusercontent.com/Long18/Long18/refs/heads/dev/assets/footers/cat_on_line.svg?sanitize=true',
            height: 40,
          ),
          const SizedBox(height: 16),
          const Text('© 2025-Present • Akshat Singh'),
        ],
      ),
    );
  }
}