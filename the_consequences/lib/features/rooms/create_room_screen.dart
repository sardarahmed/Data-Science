import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/widgets/app_widgets.dart';
import '../../data/models/game_models.dart';
import '../gameplay/game_provider.dart';

class CreateRoomScreen extends ConsumerStatefulWidget {
  const CreateRoomScreen({super.key});
  @override
  ConsumerState<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends ConsumerState<CreateRoomScreen> {
  final nickname = TextEditingController();
  int maxPlayers = 6;
  int rounds = 5;
  String mode = 'Classic';
  bool privateRoom = false;
  bool lateJoining = true;
  bool hostStarts = true;
  String? error;

  @override
  void dispose() {
    nickname.dispose();
    super.dispose();
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
            const SizedBox(width: 4),
            Text(
              'Create a room',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900),
            ),
          ],
        ),
        const SizedBox(height: 20),
        TextField(
          controller: nickname,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            labelText: 'Player nickname',
            prefixIcon: Icon(Icons.person_outline_rounded),
          ),
        ),
        const SizedBox(height: 16),
        _ChoiceSection(
          label: 'Maximum players',
          options: [for (var i = 3; i <= 10; i++) '$i'],
          selected: '$maxPlayers',
          onSelected: (value) => setState(() => maxPlayers = int.parse(value)),
        ),
        const SizedBox(height: 16),
        _ChoiceSection(
          label: 'Number of rounds',
          options: const ['3', '5', '7'],
          selected: '$rounds',
          onSelected: (value) => setState(() => rounds = int.parse(value)),
        ),
        const SizedBox(height: 16),
        _ChoiceSection(
          label: 'Game mode',
          options: const ['Classic', 'Chaotic', 'Fast'],
          selected: mode,
          onSelected: (value) => setState(() => mode = value),
        ),
        const SizedBox(height: 16),
        Card(
          margin: EdgeInsets.zero,
          child: Column(
            children: [
              SwitchListTile(
                title: const Text('Private room'),
                subtitle: const Text('Only invited players can join'),
                value: privateRoom,
                onChanged: (value) => setState(() => privateRoom = value),
              ),
              SwitchListTile(
                title: const Text('Allow late joining'),
                value: lateJoining,
                onChanged: (value) => setState(() => lateJoining = value),
              ),
              SwitchListTile(
                title: const Text('Host starts the game'),
                value: hostStarts,
                onChanged: (value) => setState(() => hostStarts = value),
              ),
            ],
          ),
        ),
        if (error != null)
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Text(
              error!,
              style: const TextStyle(color: Colors.redAccent),
            ),
          ),
        const SizedBox(height: 20),
        PrimaryButton(
          label: 'CREATE ROOM',
          icon: Icons.sports_esports_rounded,
          onPressed: () {
            if (nickname.text.trim().length < 2) {
              setState(
                () => error = 'Enter a nickname with at least 2 characters.',
              );
              return;
            }
            const chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
            final code = List.generate(
              6,
              (_) => chars[Random().nextInt(chars.length)],
            ).join();
            final room = Room(
              code: code,
              nickname: nickname.text.trim(),
              maxPlayers: maxPlayers,
              rounds: rounds,
              gameMode: mode,
              isPrivate: privateRoom,
              allowLateJoining: lateJoining,
              hostStarts: hostStarts,
            );
            ref.read(gameProvider).configureRoom(room);
            context.go('/lobby');
          },
        ),
      ],
    ),
  );
}

class _ChoiceSection extends StatelessWidget {
  final String label;
  final List<String> options;
  final String selected;
  final ValueChanged<String> onSelected;
  const _ChoiceSection({
    required this.label,
    required this.options,
    required this.selected,
    required this.onSelected,
  });
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: Theme.of(
          context,
        ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800),
      ),
      const SizedBox(height: 8),
      Wrap(
        spacing: 8,
        runSpacing: 8,
        children: options.map((option) {
          final active = option == selected;
          return ChoiceChip(
            label: Text(option),
            selected: active,
            onSelected: (_) => onSelected(option),
            selectedColor: Theme.of(context).colorScheme.primaryContainer,
          );
        }).toList(),
      ),
    ],
  );
}
