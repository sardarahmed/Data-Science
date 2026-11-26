import '../../data/models/game_models.dart';

abstract interface class RoomService {
  Future<Room> createRoom(Room room);
  Future<Room?> joinRoom(String code, String nickname);
  Future<void> expireRoom(String code);
}

abstract interface class PlayerService {
  Future<List<Player>> watchPlayers(String roomCode);
  Future<void> leaveRoom(String roomCode, String playerId);
}

abstract interface class GameService {
  Future<void> startGame(String roomCode);
  Future<void> submitVote(String roomCode, String playerId, Vote vote);
  Future<Decision> revealDecision(String roomCode, int round);
  Future<void> advanceRound(String roomCode);
}

abstract interface class ScenarioService {
  Future<List<Scenario>> fetchScenarios(List<String> excludedIds);
  Future<Scenario> fetchConnectedScenario(String previousDecisionId);
}
