import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/widgets/app_widgets.dart';
import '../../data/models/game_models.dart';
import '../gameplay/game_provider.dart';

class JoinRoomScreen extends ConsumerStatefulWidget {
  const JoinRoomScreen({super.key});
  @override
  ConsumerState<JoinRoomScreen> createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends ConsumerState<JoinRoomScreen> {
  final nickname = TextEditingController();
  final code = TextEditingController();
  String? error;

  @override
  void dispose() {
    nickname.dispose();
    code.dispose();
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
            Text(
              'Join a room',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900),
            ),
          ],
        ),
        const SizedBox(height: 32),
        TextField(
          controller: nickname,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            labelText: 'Nickname',
            prefixIcon: Icon(Icons.person_outline_rounded),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: code,
          textCapitalization: TextCapitalization.characters,
          maxLength: 6,
          decoration: const InputDecoration(
            labelText: 'Six-character room code',
            prefixIcon: Icon(Icons.tag_rounded),
            counterText: '',
          ),
          onChanged: (value) => setState(() => code.text = value.toUpperCase()),
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
          label: 'JOIN ROOM',
          icon: Icons.login_rounded,
          onPressed: () {
            final cleanCode = code.text.trim().toUpperCase();
            if (nickname.text.trim().length < 2) {
              setState(
                () => error = 'Enter a nickname with at least 2 characters.',
              );
              return;
            }
            if (cleanCode.length != 6) {
              setState(
                () => error = 'Room codes contain exactly 6 characters.',
              );
              return;
            }
            final room = Room(
              code: cleanCode,
              nickname: nickname.text.trim(),
              maxPlayers: 6,
              rounds: 5,
              gameMode: 'Classic',
            );
            ref.read(gameProvider).configureRoom(room);
            context.go('/lobby');
          },
        ),
      ],
    ),
  );
}
