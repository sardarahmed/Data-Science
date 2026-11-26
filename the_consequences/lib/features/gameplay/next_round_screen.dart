import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/widgets/app_widgets.dart';
import 'game_provider.dart';

class NextRoundScreen extends ConsumerWidget {
  const NextRoundScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(gameProvider);
    return ResponsiveScaffold(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 16),
          Text(
            'After the consequence...',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          const SizedBox(height: 12),
          Card(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                'The group wakes to a story changed by its last decision. '
                'New opportunities appear, but old choices have not disappeared.',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(height: 1.45),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'The next situation',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Round ${game.currentRound + 1} is ready to begin.',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 24),
          PrimaryButton(
            label: game.currentRound >= game.room.rounds
                ? 'VIEW FINAL RESULTS'
                : 'OPEN NEXT ROUND',
            onPressed: () {
              if (game.currentRound >= game.room.rounds) {
                context.go('/results');
              } else {
                game.nextRound();
                context.go('/game');
              }
            },
          ),
        ],
      ),
    );
  }
}
