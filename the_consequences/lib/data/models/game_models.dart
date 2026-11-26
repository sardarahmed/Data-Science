class Player {
  final String id;
  final String nickname;
  final int avatar;
  final bool isHost;
  const Player({
    required this.id,
    required this.nickname,
    required this.avatar,
    this.isHost = false,
  });
}

class Room {
  final String code;
  final String nickname;
  final int maxPlayers;
  final int rounds;
  final String gameMode;
  final bool isPrivate;
  final bool allowLateJoining;
  final bool hostStarts;
  const Room({
    required this.code,
    required this.nickname,
    required this.maxPlayers,
    required this.rounds,
    required this.gameMode,
    this.isPrivate = false,
    this.allowLateJoining = true,
    this.hostStarts = true,
  });
}

class Decision {
  final String id;
  final String text;
  final String consequence;
  const Decision({
    required this.id,
    required this.text,
    required this.consequence,
  });
}

class Scenario {
  final String id;
  final String title;
  final String story;
  final List<Decision> decisions;
  final String category;
  const Scenario({
    required this.id,
    required this.title,
    required this.story,
    required this.decisions,
    required this.category,
  });
}

class Vote {
  final String playerId;
  final String decisionId;
  const Vote({required this.playerId, required this.decisionId});
}

class GameSession {
  final Room room;
  final List<Player> players;
  final int currentRound;
  final List<Scenario> scenarios;
  const GameSession({
    required this.room,
    required this.players,
    required this.currentRound,
    required this.scenarios,
  });
}

class GameResult {
  final String finalStory;
  final Map<String, int> playerScores;
  const GameResult({required this.finalStory, required this.playerScores});
}
