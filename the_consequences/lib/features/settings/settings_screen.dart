import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:go_router/go_router.dart';
import '../../app/app.dart';
import '../../core/widgets/app_widgets.dart';

final soundProvider = StateProvider<bool>((ref) => true);
final hapticsProvider = StateProvider<bool>((ref) => true);

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dark = ref.watch(themeModeProvider) == ThemeMode.dark;
    return ResponsiveScaffold(
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
                'Settings',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Card(
            margin: EdgeInsets.zero,
            child: Column(
              children: [
                SwitchListTile(
                  secondary: const Icon(Icons.dark_mode_rounded),
                  title: const Text('Dark mode'),
                  value: dark,
                  onChanged: (value) =>
                      ref.read(themeModeProvider.notifier).state = value
                      ? ThemeMode.dark
                      : ThemeMode.light,
                ),
                SwitchListTile(
                  secondary: const Icon(Icons.volume_up_rounded),
                  title: const Text('Sound'),
                  value: ref.watch(soundProvider),
                  onChanged: (value) =>
                      ref.read(soundProvider.notifier).state = value,
                ),
                SwitchListTile(
                  secondary: const Icon(Icons.vibration_rounded),
                  title: const Text('Haptic feedback'),
                  value: ref.watch(hapticsProvider),
                  onChanged: (value) =>
                      ref.read(hapticsProvider.notifier).state = value,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Card(
            margin: EdgeInsets.zero,
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.language_rounded),
                  title: const Text('Language'),
                  subtitle: const Text('English'),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () {},
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.info_outline_rounded),
                  title: const Text('About the game'),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () {},
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.privacy_tip_outlined),
                  title: const Text('Privacy policy'),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
