import 'dart:math';
import 'package:flutter/material.dart';
import 'package:akshat_portfolio/theme/app_theme.dart';

class Particle {
  Offset position;
  Offset velocity;
  double radius;
  Color color;

  Particle({required this.position, required this.velocity, this.radius = 2.0, this.color = Colors.white});
}

class ParticleBackground extends StatefulWidget {
  const ParticleBackground({super.key});

  @override
  State<ParticleBackground> createState() => _ParticleBackgroundState();
}

class _ParticleBackgroundState extends State<ParticleBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<Particle> particles = [];
  Offset? mousePosition;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addListener(() {
        setState(() {
          _updateParticles();
        });
      });
    _controller.repeat();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (particles.isEmpty) {
      _initializeParticles();
    }
  }

  void _initializeParticles() {
    final size = MediaQuery.of(context).size;
    final random = Random();
    int particleCount = (size.width * size.height / 10000).clamp(50, 150).toInt();

    for (int i = 0; i < particleCount; i++) {
      particles.add(Particle(
        position: Offset(random.nextDouble() * size.width, random.nextDouble() * size.height),
        velocity: Offset((random.nextDouble() - 0.5) * 0.5, (random.nextDouble() - 0.5) * 0.5),
        color: AppTheme.primaryColor.withValues(alpha:random.nextDouble().clamp(0.2, 0.8)),
        radius: random.nextDouble() * 2 + 1,
      ));
    }
  }

  void _updateParticles() {
    final size = MediaQuery.of(context).size;
    for (var p in particles) {
      p.position += p.velocity;

      if (p.position.dx < 0 || p.position.dx > size.width) {
        p.velocity = Offset(-p.velocity.dx, p.velocity.dy);
      }
      if (p.position.dy < 0 || p.position.dy > size.height) {
        p.velocity = Offset(p.velocity.dx, -p.velocity.dy);
      }

      if (mousePosition != null) {
        final distance = (p.position - mousePosition!).distance;
        if (distance < 100) {
          final direction = (p.position - mousePosition!).dx.sign;
          p.velocity += Offset(direction * 0.05, 0);
        }
      }

      p.velocity = Offset(p.velocity.dx.clamp(-1.0, 1.0), p.velocity.dy.clamp(-1.0, 1.0));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) {
        setState(() {
          mousePosition = event.position;
        });
      },
      onExit: (event) {
        setState(() {
          mousePosition = null;
        });
      },
      child: CustomPaint(
        painter: ParticlePainter(particles: particles, mousePosition: mousePosition),
        child: Container(),
      ),
    );
  }
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;
  final Offset? mousePosition;

  ParticlePainter({required this.particles, this.mousePosition});

  @override
  void paint(Canvas canvas, Size size) {
    final particlePaint = Paint();
    final linePaint = Paint()
      ..color = AppTheme.borderColor.withValues(alpha:0.5)
      ..strokeWidth = 0.5;

    for (var p1 in particles) {
      particlePaint.color = p1.color;
      canvas.drawCircle(p1.position, p1.radius, particlePaint);

      for (var p2 in particles) {
        final distance = (p1.position - p2.position).distance;
        if (distance < 120) {
          linePaint.color = AppTheme.borderColor.withValues(alpha:(1 - distance / 120) * 0.3);
          canvas.drawLine(p1.position, p2.position, linePaint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}