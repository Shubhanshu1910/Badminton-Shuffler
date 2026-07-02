
class PlayerMatchModel {
  final String id;
  final String name;
  final int skillLevel;
  final int team;
  final int position;

  PlayerMatchModel({
    required this.id,
    required this.name,
    required this.skillLevel,
    required this.team,
    required this.position,
  });

  factory PlayerMatchModel.fromJson(
    Map<String, dynamic> json,
  ) {
    final player = json["player"] as Map<String, dynamic>?;

    return PlayerMatchModel(
      id: player?["id"] ?? json["playerId"] ?? "",
      name: player?["name"] ?? "",
      skillLevel: player?["skillLevel"] ?? 0,
      team: json["team"] ?? 0,
      position: json["position"] ?? 0,
    );
  }
}