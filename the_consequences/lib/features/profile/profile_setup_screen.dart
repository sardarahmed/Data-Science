import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/widgets/app_widgets.dart';
import '../../data/models/profile.dart';
import '../auth/auth_provider.dart';

class ProfileSetupScreen extends ConsumerStatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  ConsumerState<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends ConsumerState<ProfileSetupScreen> {
  final username = TextEditingController();
  final displayName = TextEditingController();
  final bio = TextEditingController();
  int avatar = 0;
  String? error;

  @override
  void dispose() {
    username.dispose();
    displayName.dispose();
    bio.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Future<void>.microtask(() {
      final profile = ref.read(authProfileProvider);
      if (profile != null) {
        username.text = profile.username;
        displayName.text = profile.displayName;
        bio.text = profile.bio;
      }
    });
  }

  Future<void> save() async {
    final cleanUsername = username.text.trim().toLowerCase();
    if (!RegExp(r'^[a-z0-9_]{3,20}$').hasMatch(cleanUsername)) {
      setState(
        () => error =
            'Username must be 3–20 characters: letters, numbers or underscores.',
      );
      return;
    }
    if (displayName.text.trim().length < 2) {
      setState(() => error = 'Enter a display name.');
      return;
    }
    final current = ref.read(authProfileProvider);
    if (current == null) {
      setState(() => error = 'Verify your email before creating a profile.');
      return;
    }
    await ref
        .read(authProfileProvider.notifier)
        .saveProfile(
          UserProfile(
            id: current.id,
            username: cleanUsername,
            displayName: displayName.text.trim(),
            email: current.email,
            bio: bio.text.trim(),
            createdAt: current.createdAt,
            totalMatches: current.totalMatches,
            totalWins: current.totalWins,
            totalPoints: current.totalPoints,
          ),
        );
    if (mounted) context.go('/home');
  }

  @override
  Widget build(BuildContext context) => ResponsiveScaffold(
    child: ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          'Create your profile',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            6,
            (index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: GestureDetector(
                onTap: () => setState(() => avatar = index),
                child: CircleAvatar(
                  radius: avatar == index ? 30 : 24,
                  backgroundColor: avatar == index
                      ? const Color(0xFF8057FF)
                      : const Color(0xFF222438),
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: username,
          decoration: const InputDecoration(
            labelText: 'Username',
            prefixText: '@',
          ),
        ),
        const SizedBox(height: 14),
        TextField(
          controller: displayName,
          decoration: const InputDecoration(labelText: 'Display name'),
        ),
        const SizedBox(height: 14),
        TextField(
          controller: bio,
          maxLines: 3,
          decoration: const InputDecoration(
            labelText: 'Bio',
            alignLabelWithHint: true,
          ),
        ),
        if (error != null) ...[
          const SizedBox(height: 10),
          Text(
            error!,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.redAccent),
          ),
        ],
        const SizedBox(height: 20),
        PrimaryButton(
          label: 'SAVE PROFILE',
          icon: Icons.check_rounded,
          onPressed: save,
        ),
      ],
    ),
  );
}
