class PlayerModel {
  final String id;
  final String name;
  final String? phone;
  final int skillLevel;
  final int gamesPlayed;
  final int gamesWon;
  final int gamesLost;
  final int gamesWaited;

  PlayerModel({
    required this.id,
    required this.name,
    this.phone,
    required this.skillLevel,
    required this.gamesPlayed,
    required this.gamesWon,
    required this.gamesLost,
    required this.gamesWaited,
  });

  factory PlayerModel.fromJson(
      Map<String, dynamic> json) {
    return PlayerModel(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      skillLevel: json['skillLevel'],
      gamesPlayed: json['gamesPlayed'],
      gamesWon: json['gamesWon'],
      gamesLost: json['gamesLost'],
      gamesWaited: json['gamesWaited'],
    );
  }
}