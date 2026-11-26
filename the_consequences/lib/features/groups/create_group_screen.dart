import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/widgets/app_widgets.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final name = TextEditingController();
  final description = TextEditingController();
  String category = 'Friends';
  bool isPublic = true;
  bool requireApproval = false;
  String? error;

  @override
  void dispose() {
    name.dispose();
    description.dispose();
    super.dispose();
  }

  void create() {
    if (name.text.trim().length < 3) {
      setState(() => error = 'Enter a group name with at least 3 characters.');
      return;
    }
    const chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
    final code = List.generate(
      8,
      (_) => chars[Random().nextInt(chars.length)],
    ).join();
    context.push(
      '/groups/detail',
      extra: {
        'name': name.text.trim(),
        'description': description.text.trim(),
        'code': code,
        'category': category,
        'public': isPublic,
        'approval': requireApproval,
      },
    );
  }

  @override
  Widget build(BuildContext context) => ResponsiveScaffold(
    child: ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.arrow_back_rounded),
            ),
            Text(
              'Create a group',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900),
            ),
          ],
        ),
        const SizedBox(height: 18),
        TextField(
          controller: name,
          decoration: const InputDecoration(
            labelText: 'Group name',
            prefixIcon: Icon(Icons.groups_rounded),
          ),
        ),
        const SizedBox(height: 14),
        TextField(
          controller: description,
          maxLines: 3,
          decoration: const InputDecoration(
            labelText: 'Description',
            alignLabelWithHint: true,
          ),
        ),
        const SizedBox(height: 14),
        DropdownButtonFormField<String>(
          initialValue: category,
          decoration: const InputDecoration(labelText: 'Category'),
          items:
              const [
                    'Friends',
                    'University',
                    'Gaming',
                    'Family',
                    'Entertainment',
                    'Other',
                  ]
                  .map(
                    (value) =>
                        DropdownMenuItem(value: value, child: Text(value)),
                  )
                  .toList(),
          onChanged: (value) => setState(() => category = value ?? 'Friends'),
        ),
        const SizedBox(height: 10),
        SwitchListTile(
          title: const Text('Public group'),
          subtitle: const Text('Visible in public group discovery'),
          value: isPublic,
          onChanged: (value) => setState(() => isPublic = value),
        ),
        SwitchListTile(
          title: const Text('Join approval'),
          subtitle: const Text('Members require owner approval'),
          value: requireApproval,
          onChanged: (value) => setState(() => requireApproval = value),
        ),
        if (error != null)
          Text(
            error!,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.redAccent),
          ),
        const SizedBox(height: 18),
        PrimaryButton(
          label: 'CREATE GROUP',
          icon: Icons.add_rounded,
          onPressed: create,
        ),
      ],
    ),
  );
}
