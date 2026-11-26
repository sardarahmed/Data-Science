class SocialGroup {
  final String id;
  final String name;
  final String description;
  final String joinCode;
  final String category;
  final bool isPublic;
  final bool requireApproval;
  final int memberCount;

  const SocialGroup({
    required this.id,
    required this.name,
    required this.description,
    required this.joinCode,
    required this.category,
    required this.isPublic,
    this.requireApproval = false,
    this.memberCount = 1,
  });
}
