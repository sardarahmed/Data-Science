import 'dart:math';
import '../../core/services/service_interfaces.dart';
import '../models/game_models.dart';
import '../../features/scenarios/scenario_data.dart';

class DemoRoomService implements RoomService {
  @override
  Future<Room> createRoom(Room room) async => room;

  @override
  Future<Room?> joinRoom(String code, String nickname) async {
    if (code.trim().length != 6) return null;
    return Room(
      code: code.toUpperCase(),
      nickname: nickname,
      maxPlayers: 6,
      rounds: 5,
      gameMode: 'Classic',
    );
  }

  @override
  Future<void> expireRoom(String code) async {}
}

class DemoPlayerService implements PlayerService {
  @override
  Future<void> leaveRoom(String roomCode, String playerId) async {}

  @override
  Future<List<Player>> watchPlayers(String roomCode) async => const [
    Player(id: '1', nickname: 'Alex', avatar: 0, isHost: true),
    Player(id: '2', nickname: 'Mia', avatar: 1),
    Player(id: '3', nickname: 'Zoe', avatar: 2),
  ];
}

class DemoGameService implements GameService {
  @override
  Future<void> advanceRound(String roomCode) async {}

  @override
  Future<Decision> revealDecision(String roomCode, int round) async =>
      scenarioTemplates[round % scenarioTemplates.length].decisions[Random()
          .nextInt(4)];

  @override
  Future<void> startGame(String roomCode) async {}

  @override
  Future<void> submitVote(String roomCode, String playerId, Vote vote) async {}
}

class DemoScenarioService implements ScenarioService {
  @override
  Future<List<Scenario>> fetchScenarios(List<String> excludedIds) async =>
      allScenarios.where((item) => !excludedIds.contains(item.id)).toList();

  @override
  Future<Scenario> fetchConnectedScenario(String previousDecisionId) async =>
      allScenarios.firstWhere(
        (item) => item.id != previousDecisionId,
        orElse: () => allScenarios.first,
      );
}
