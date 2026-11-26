import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme/app_theme.dart';
import '../../core/widgets/app_widgets.dart';
import 'game_provider.dart';

class ConsequenceRevealScreen extends ConsumerWidget {
  const ConsequenceRevealScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(gameProvider);
    final decision = game.currentScenario.decisions.firstWhere(
      (item) => item.id == game.revealedDecisionId,
      orElse: () => game.currentScenario.decisions.first,
    );
    return ResponsiveScaffold(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 20),
          const Center(
            child: Icon(
              Icons.auto_awesome_rounded,
              size: 58,
              color: AppColors.secondary,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'THE CONSEQUENCE',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: AppColors.secondary,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            decision.text,
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 20),
          Card(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Icon(
                    Icons.change_circle_rounded,
                    color: AppColors.success,
                    size: 36,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    decision.consequence,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 17, height: 1.5),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            color: AppColors.primary.withValues(alpha: .12),
            margin: EdgeInsets.zero,
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Unexpected consequence: the decision reshapes the entire group’s next move.',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.textSecondary),
              ),
            ),
          ),
          const SizedBox(height: 24),
          PrimaryButton(
            label: 'CONTINUE',
            icon: Icons.arrow_forward_rounded,
            onPressed: () => context.go('/next'),
          ),
        ],
      ),
    );
  }
}
