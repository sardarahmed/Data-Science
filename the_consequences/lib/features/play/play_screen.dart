import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/widgets/app_widgets.dart';

class PlayScreen extends StatelessWidget {
  const PlayScreen({super.key});

  @override
  Widget build(BuildContext context) => ResponsiveScaffold(
    child: ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          'Play',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 18),
        Card(
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'DAILY CONSEQUENCE',
                  style: TextStyle(
                    color: Color(0xFFFF795E),
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Would you erase one embarrassing memory?',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 14),
                PrimaryButton(
                  label: 'ANSWER DAILY CHALLENGE',
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: PrimaryButton(
                label: 'CREATE ROOM',
                icon: Icons.add_rounded,
                onPressed: () => context.push('/create'),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: SecondaryButton(
                label: 'JOIN ROOM',
                icon: Icons.login_rounded,
                onPressed: () => context.push('/join'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text('Active matches', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        const Card(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'No active matches. Start a room or join one with your friends.',
              style: TextStyle(color: Color(0xFFA5A8BA)),
            ),
          ),
        ),
      ],
    ),
  );
}
