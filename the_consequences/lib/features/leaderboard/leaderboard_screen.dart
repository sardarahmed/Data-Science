import 'package:flutter/material.dart';

import '../../core/widgets/app_widgets.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) => ResponsiveScaffold(
    child: ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          'Leaderboard',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 12),
        const DefaultTabController(
          length: 3,
          child: Column(
            children: [
              TabBar(
                tabs: [
                  Tab(text: 'Weekly'),
                  Tab(text: 'Monthly'),
                  Tab(text: 'All-time'),
                ],
              ),
              SizedBox(height: 12),
            ],
          ),
        ),
        ...[
          ('Alex', 1840, 3),
          ('Mia', 1725, 2),
          ('Zoe', 1610, 4),
          ('Noah', 1490, 1),
        ].indexed.map(
          (item) => Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: ListTile(
              leading: CircleAvatar(child: Text('${item.$1 + 1}')),
              title: Text(
                item.$2.$1,
                style: const TextStyle(fontWeight: FontWeight.w800),
              ),
              subtitle: Text('${item.$2.$3} wins'),
              trailing: Text(
                '${item.$2.$2} pts',
                style: const TextStyle(fontWeight: FontWeight.w900),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
