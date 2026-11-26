import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/widgets/app_widgets.dart';

class GroupsScreen extends StatelessWidget {
  const GroupsScreen({super.key});

  @override
  Widget build(BuildContext context) => ResponsiveScaffold(
    child: ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Row(
          children: [
            Text(
              'Groups',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900),
            ),
            const Spacer(),
            IconButton(
              onPressed: () => context.push('/groups/create'),
              icon: const Icon(Icons.add_circle_outline_rounded),
            ),
          ],
        ),
        const SizedBox(height: 12),
        TextField(
          decoration: const InputDecoration(
            hintText: 'Search groups or enter a join code',
            prefixIcon: Icon(Icons.search_rounded),
          ),
        ),
        const SizedBox(height: 18),
        Text('Popular groups', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        const _GroupCard(
          name: 'Late Night Legends',
          description: 'Weekly chaos, excellent friends.',
          members: 48,
          category: 'Gaming',
          public: true,
        ),
        const _GroupCard(
          name: 'Campus Consequences',
          description: 'University stories and daily challenges.',
          members: 126,
          category: 'University',
          public: true,
        ),
        const _GroupCard(
          name: 'The Sunday Circle',
          description: 'A private family game night.',
          members: 9,
          category: 'Family',
          public: false,
        ),
      ],
    ),
  );
}

class _GroupCard extends StatelessWidget {
  final String name;
  final String description;
  final int members;
  final String category;
  final bool public;

  const _GroupCard({
    required this.name,
    required this.description,
    required this.members,
    required this.category,
    required this.public,
  });

  @override
  Widget build(BuildContext context) => Card(
    margin: const EdgeInsets.only(bottom: 10),
    child: InkWell(
      onTap: () => context.push(
        '/groups/detail',
        extra: {
          'name': name,
          'description': description,
          'code': 'GROUP8X',
          'category': category,
          'public': public,
        },
      ),
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            CircleAvatar(radius: 28, child: Text(name.characters.first)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Icon(
                        public
                            ? Icons.public_rounded
                            : Icons.lock_outline_rounded,
                        size: 16,
                      ),
                    ],
                  ),
                  Text(
                    description,
                    style: const TextStyle(color: Color(0xFFA5A8BA)),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '$category · $members members',
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            OutlinedButton(onPressed: () {}, child: const Text('Open')),
          ],
        ),
      ),
    ),
  );
}
