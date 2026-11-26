import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme/app_theme.dart';
import '../../core/widgets/app_widgets.dart';
import '../gameplay/game_provider.dart';

class FinalResultsScreen extends ConsumerWidget {
  const FinalResultsScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(gameProvider);
    return ResponsiveScaffold(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Center(
            child: Icon(
              Icons.emoji_events_rounded,
              size: 72,
              color: Color(0xFFFFCF66),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Your final story',
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 12),
          Card(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                'The group chose uncertainty, loyalty, and a little chaos. '
                'After ${game.room.rounds} consequences, each player left the story changed—and every friendship had a better story to tell.',
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(height: 1.5),
              ),
            ),
          ),
          const SizedBox(height: 18),
          Text('Game awards', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 10),
          const _AwardTile(
            icon: Icons.mood_rounded,
            title: 'Funniest decision',
            name: 'Zoe',
          ),
          const _AwardTile(
            icon: Icons.flash_on_rounded,
            title: 'Most unexpected',
            name: 'Noah',
          ),
          const _AwardTile(
            icon: Icons.bolt_rounded,
            title: 'Most chaotic player',
            name: 'Mia',
          ),
          const SizedBox(height: 12),
          Text(
            'Player statistics',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 10),
          ...game.players.map(
            (player) => Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: PlayerAvatar(
                  name: player.nickname,
                  avatar: player.avatar,
                ),
                title: Text(
                  player.nickname,
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
                trailing: Text(
                  '${3 + player.avatar} decisions',
                  style: const TextStyle(color: AppColors.textSecondary),
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),
          PrimaryButton(
            label: 'PLAY AGAIN',
            icon: Icons.replay_rounded,
            onPressed: () {
              game.reset();
              context.go('/lobby');
            },
          ),
          const SizedBox(height: 10),
          SecondaryButton(
            label: 'RETURN HOME',
            icon: Icons.home_rounded,
            onPressed: () => context.go('/home'),
          ),
        ],
      ),
    );
  }
}

class _AwardTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String name;
  const _AwardTile({
    required this.icon,
    required this.title,
    required this.name,
  });
  @override
  Widget build(BuildContext context) => Card(
    margin: const EdgeInsets.only(bottom: 8),
    child: ListTile(
      leading: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: .14),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: AppColors.primary),
      ),
      title: Text(title),
      trailing: Text(name, style: const TextStyle(fontWeight: FontWeight.w900)),
    ),
  );
}
