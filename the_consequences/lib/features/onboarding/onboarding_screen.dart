import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme/app_theme.dart';
import '../../core/widgets/app_widgets.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = PageController();
  int index = 0;
  final slides = const [
    (
      Icons.meeting_room_rounded,
      'Create a room',
      'Start a private or public game and set the rhythm for the night.',
    ),
    (
      Icons.group_add_rounded,
      'Invite your friends',
      'Share one simple code and bring everyone into the story.',
    ),
    (
      Icons.auto_awesome_rounded,
      'Make choices',
      'Choose in secret, face the consequence, and see where the story goes.',
    ),
  ];

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: TextButton(
              onPressed: () => context.go('/auth'),
              child: const Text('Skip'),
            ),
          ),
          Expanded(
            child: PageView.builder(
              controller: controller,
              onPageChanged: (value) => setState(() => index = value),
              itemCount: slides.length,
              itemBuilder: (_, i) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: .12),
                        borderRadius: BorderRadius.circular(90),
                      ),
                      child: Icon(
                        slides[i].$1,
                        size: 84,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 36),
                    Text(
                      slides[i].$2,
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(fontWeight: FontWeight.w900),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      slides[i].$3,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              slides.length,
              (i) => AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: i == index ? 24 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: i == index
                      ? AppColors.primary
                      : AppColors.textSecondary.withValues(alpha: .3),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: PrimaryButton(
              label: index == slides.length - 1 ? 'ENTER THE GAME' : 'NEXT',
              onPressed: () {
                if (index == slides.length - 1) {
                  context.go('/auth');
                } else {
                  controller.nextPage(
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.easeOut,
                  );
                }
              },
            ),
          ),
        ],
      ),
    ),
  );
}
