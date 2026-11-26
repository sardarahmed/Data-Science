import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import '../../app/theme/app_theme.dart';
import '../../core/widgets/app_widgets.dart';
import '../gameplay/game_provider.dart';

class GameLobbyScreen extends ConsumerWidget {
  const GameLobbyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(gameProvider);
    return ResponsiveScaffold(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => context.go('/home'),
                icon: const Icon(Icons.close_rounded),
              ),
              const Spacer(),
              const Text(
                'WAITING FOR PLAYERS',
                style: TextStyle(
                  color: AppColors.success,
                  fontWeight: FontWeight.w900,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text('Room code', style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 8),
          Card(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      game.room.code,
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            fontWeight: FontWeight.w900,
                            letterSpacing: 8,
                          ),
                    ),
                  ),
                  IconButton(
                    tooltip: 'Copy room code',
                    onPressed: () async {
                      await Clipboard.setData(
                        ClipboardData(text: game.room.code),
                      );
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Room code copied')),
                        );
                      }
                    },
                    icon: const Icon(Icons.copy_rounded),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          SecondaryButton(
            label: 'SHARE INVITATION',
            icon: Icons.share_rounded,
            onPressed: () => SharePlus.instance.share(
              ShareParams(
                text:
                    'Join my The Consequence room using code ${game.room.code}!',
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Text('Players', style: Theme.of(context).textTheme.titleLarge),
              const Spacer(),
              Text(
                '${game.players.length}/${game.room.maxPlayers}',
                style: const TextStyle(color: AppColors.textSecondary),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...game.players.map(
            (player) => Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: PlayerAvatar(
                  name: player.nickname,
                  avatar: player.avatar,
                  host: player.isHost,
                ),
                title: Text(
                  player.nickname,
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
                subtitle: Text(player.isHost ? 'Host' : 'Ready'),
                trailing: Icon(
                  player.isHost
                      ? Icons.star_rounded
                      : Icons.check_circle_rounded,
                  color: player.isHost
                      ? const Color(0xFFFFCF66)
                      : AppColors.success,
                ),
              ),
            ),
          ),
          const SizedBox(height: 18),
          PrimaryButton(
            label: 'START GAME',
            icon: Icons.play_arrow_rounded,
            onPressed: game.players.length >= 3
                ? () => context.go('/game')
                : null,
          ),
          if (game.players.length < 3)
            const Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text(
                'At least 3 players are needed to start.',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.textSecondary),
              ),
            ),
        ],
      ),
    );
  }
}
