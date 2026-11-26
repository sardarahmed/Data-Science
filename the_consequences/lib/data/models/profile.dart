class UserProfile {
  final String id;
  final String username;
  final String displayName;
  final String email;
  final String? avatarUrl;
  final String bio;
  final DateTime createdAt;
  final int totalMatches;
  final int totalWins;
  final int totalPoints;

  const UserProfile({
    required this.id,
    required this.username,
    required this.displayName,
    required this.email,
    this.avatarUrl,
    this.bio = '',
    required this.createdAt,
    this.totalMatches = 0,
    this.totalWins = 0,
    this.totalPoints = 0,
  });
}
