import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme/app_theme.dart';
import '../../core/widgets/app_widgets.dart';
import 'game_provider.dart';

class GameScreen extends ConsumerWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(gameProvider);
    final scenario = game.currentScenario;
    final isWide = MediaQuery.sizeOf(context).width > 800;
    return ResponsiveScaffold(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Row(
            children: [
              Text(
                'ROUND ${game.currentRound}/${game.room.rounds}',
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  color: AppColors.secondary,
                ),
              ),
              const Spacer(),
              Text(
                '${(game.currentRound / game.room.rounds * 100).round()}%',
                style: const TextStyle(color: AppColors.textSecondary),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: game.currentRound / game.room.rounds,
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            scenario.title,
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 10),
          Text(
            scenario.story,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.textSecondary,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 22),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isWide ? 2 : 1,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              mainAxisExtent: 112,
            ),
            itemCount: scenario.decisions.length,
            itemBuilder: (_, i) {
              final decision = scenario.decisions[i];
              final selected = game.selectedDecisionId == decision.id;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeOut,
                child: InkWell(
                  onTap: () => game.selectDecision(decision.id),
                  borderRadius: BorderRadius.circular(18),
                  child: Ink(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: selected
                          ? AppColors.primary.withValues(alpha: .18)
                          : AppColors.elevated,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: selected
                            ? AppColors.primary
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 34,
                          height: 34,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: selected
                                ? AppColors.primary
                                : AppColors.surface,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '${i + 1}',
                            style: const TextStyle(fontWeight: FontWeight.w900),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            decision.text,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        if (selected)
                          const Icon(
                            Icons.check_circle_rounded,
                            color: AppColors.success,
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          PrimaryButton(
            label: 'CONFIRM CHOICE',
            icon: Icons.lock_rounded,
            onPressed: game.selectedDecisionId == null
                ? null
                : () {
                    game.reveal();
                    context.go('/reveal');
                  },
          ),
          const SizedBox(height: 8),
          const Text(
            'Other players cannot see your choice.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
