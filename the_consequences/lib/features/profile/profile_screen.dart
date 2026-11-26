import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

import '../../core/widgets/app_widgets.dart';
import '../auth/auth_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(authProfileProvider);
    if (profile == null) {
      return const EmptyStateWidget(
        icon: Icons.person_outline_rounded,
        title: 'Not signed in',
        message: 'Verify your email to view your profile.',
      );
    }
    return ResponsiveScaffold(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 38,
                child: Icon(Icons.person_rounded, size: 38),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      profile.displayName,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      '@${profile.username}',
                      style: const TextStyle(color: Color(0xFFA5A8BA)),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => SharePlus.instance.share(
                  ShareParams(
                    text: 'Add @${profile.username} on The Consequence',
                  ),
                ),
                icon: const Icon(Icons.share_rounded),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(profile.bio),
          const SizedBox(height: 18),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _StatChip('${profile.totalMatches}', 'Matches'),
              _StatChip('${profile.totalWins}', 'Wins'),
              _StatChip('${profile.totalPoints}', 'Points'),
              const _StatChip('4', 'Achievements'),
            ],
          ),
          const SizedBox(height: 18),
          PrimaryButton(
            label: 'EDIT PROFILE',
            icon: Icons.edit_rounded,
            onPressed: () => context.push('/profile/setup'),
          ),
          const SizedBox(height: 10),
          SecondaryButton(
            label: 'SETTINGS',
            icon: Icons.settings_rounded,
            onPressed: () => context.push('/settings'),
          ),
          const SizedBox(height: 10),
          OutlinedButton(
            onPressed: () async {
              await ref.read(authProfileProvider.notifier).logout();
              if (context.mounted) context.go('/auth');
            },
            child: const Text('LOG OUT'),
          ),
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String value;
  final String label;

  const _StatChip(this.value, this.label);

  @override
  Widget build(BuildContext context) => Card(
    margin: EdgeInsets.zero,
    child: SizedBox(
      width: 150,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            Text(
              value,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
            ),
            Text(label, style: const TextStyle(color: Color(0xFFA5A8BA))),
          ],
        ),
      ),
    ),
  );
}
