class SessionModel {
  final String id;
  final String title;
  final String? description;
  final String status;
  final int totalCourts;
  final int maxPlayers;
  final int currentRound;

  SessionModel({
    required this.id,
    required this.title,
    this.description,
    required this.status,
    required this.totalCourts,
    required this.maxPlayers,
    required this.currentRound,
  });

  factory SessionModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return SessionModel(
      id: json["id"],
      title: json["title"] ?? "",
      description: json["description"],
      status: json["status"] ?? "DRAFT",
      totalCourts: json["totalCourts"] ?? 0,
      maxPlayers: json["maxPlayers"] ?? 0,
      currentRound: json["currentRound"] ?? 0,
    );
  }
}