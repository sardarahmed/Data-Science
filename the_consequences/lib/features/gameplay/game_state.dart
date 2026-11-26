import 'dart:math';
import 'package:flutter/foundation.dart';

import '../../data/models/game_models.dart';
import '../scenarios/scenario_data.dart';

class GameState extends ChangeNotifier {
  Room room = const Room(
    code: 'CX42',
    nickname: 'Alex',
    maxPlayers: 6,
    rounds: 5,
    gameMode: 'Classic',
  );
  List<Player> players = const [
    Player(id: '1', nickname: 'Alex', avatar: 0, isHost: true),
    Player(id: '2', nickname: 'Mia', avatar: 1),
    Player(id: '3', nickname: 'Zoe', avatar: 2),
    Player(id: '4', nickname: 'Noah', avatar: 3),
  ];
  int currentRound = 1;
  String? selectedDecisionId;
  String? revealedDecisionId;
  final List<Scenario> usedScenarios = [];
  late Scenario currentScenario;

  GameState() {
    currentScenario = allScenarios.first;
  }

  void configureRoom(Room value) {
    room = value;
    players = [
      Player(
        id: 'host',
        nickname: value.nickname,
        avatar: Random().nextInt(6),
        isHost: true,
      ),
      const Player(id: 'demo2', nickname: 'Mia', avatar: 1),
      const Player(id: 'demo3', nickname: 'Zoe', avatar: 2),
    ];
    currentRound = 1;
    usedScenarios.clear();
    currentScenario = allScenarios.first;
    notifyListeners();
  }

  void selectDecision(String id) {
    selectedDecisionId = id;
    notifyListeners();
  }

  void reveal() {
    revealedDecisionId =
        selectedDecisionId ?? currentScenario.decisions.first.id;
    usedScenarios.add(currentScenario);
    notifyListeners();
  }

  void nextRound() {
    if (currentRound >= room.rounds) return;
    currentRound++;
    selectedDecisionId = null;
    revealedDecisionId = null;
    final available = allScenarios
        .where((item) => !usedScenarios.any((used) => used.id == item.id))
        .toList();
    currentScenario = available.isEmpty
        ? allScenarios[currentRound % allScenarios.length]
        : available[Random().nextInt(available.length)];
    notifyListeners();
  }

  void reset() {
    currentRound = 1;
    selectedDecisionId = null;
    revealedDecisionId = null;
    usedScenarios.clear();
    currentScenario = allScenarios.first;
    notifyListeners();
  }
}
