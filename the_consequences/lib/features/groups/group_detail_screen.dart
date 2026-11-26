import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

import '../../core/widgets/app_widgets.dart';

class GroupDetailScreen extends StatelessWidget {
  final Map<String, dynamic> extra;

  const GroupDetailScreen({super.key, required this.extra});

  @override
  Widget build(BuildContext context) {
    final name = extra['name'] as String? ?? 'Late Night Legends';
    final description =
        extra['description'] as String? ?? 'Weekly chaos, excellent friends.';
    final code = extra['code'] as String? ?? 'NIGHT42';
    final isPublic = extra['public'] as bool? ?? true;

    return ResponsiveScaffold(
      child: DefaultTabController(
        length: 5,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => context.pop(),
                        icon: const Icon(Icons.arrow_back_rounded),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () => SharePlus.instance.share(
                          ShareParams(text: 'Join $name using code $code'),
                        ),
                        icon: const Icon(Icons.share_rounded),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.more_vert_rounded),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    radius: 38,
                    child: Text(
                      name.characters.first,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    name,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        isPublic
                            ? Icons.public_rounded
                            : Icons.lock_outline_rounded,
                        size: 16,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        isPublic
                            ? 'Public group · 48 members'
                            : 'Private group',
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  OutlinedButton.icon(
                    onPressed: () async {
                      await Clipboard.setData(ClipboardData(text: code));
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Group code copied')),
                        );
                      }
                    },
                    icon: const Icon(Icons.copy_rounded),
                    label: Text(code),
                  ),
                ],
              ),
            ),
            const TabBar(
              isScrollable: true,
              tabs: [
                Tab(text: 'Overview'),
                Tab(text: 'Members'),
                Tab(text: 'Activity'),
                Tab(text: 'Leaderboard'),
                Tab(text: 'Matches'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ListView(
                    padding: const EdgeInsets.all(20),
                    children: [
                      Text(description),
                      const SizedBox(height: 16),
                      PrimaryButton(
                        label: 'PLAY NOW',
                        icon: Icons.sports_esports_rounded,
                        onPressed: () => context.push('/create'),
                      ),
                      const SizedBox(height: 12),
                      const Card(
                        child: ListTile(
                          leading: Icon(Icons.emoji_events_rounded),
                          title: Text('Daily consequence'),
                          subtitle: Text(
                            'Would you erase one embarrassing memory?',
                          ),
                          trailing: Icon(Icons.chevron_right_rounded),
                        ),
                      ),
                    ],
                  ),
                  const Center(child: Text('Members: Alex, Mia, Zoe, Noah')),
                  const EmptyStateWidget(
                    icon: Icons.timeline_rounded,
                    title: 'No recent activity',
                    message:
                        'Group invitations and completed matches will appear here.',
                  ),
                  const Center(
                    child: Text('1. Mia — 1725 pts\n2. Alex — 1840 pts'),
                  ),
                  const EmptyStateWidget(
                    icon: Icons.history_rounded,
                    title: 'No match history',
                    message: 'Completed group matches will appear here.',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
