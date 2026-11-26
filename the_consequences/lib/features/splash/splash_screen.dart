import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme/app_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _controller.forward();
    Future<void>.delayed(const Duration(milliseconds: 2200), () {
      if (mounted) context.go('/onboarding');
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: FadeTransition(
      opacity: _fade,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(28),
                boxShadow: const [
                  BoxShadow(color: Color(0x558057FF), blurRadius: 30),
                ],
              ),
              child: const Icon(
                Icons.bolt_rounded,
                size: 54,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'THE CONSEQUENCE',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w900,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'One choice can change everything.',
              style: TextStyle(color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
    ),
  );
}
