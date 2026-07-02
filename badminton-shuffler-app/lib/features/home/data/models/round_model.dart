class RoundModel {
  final String id;
  final int roundNumber;
  final String status;

  RoundModel({
    required this.id,
    required this.roundNumber,
    required this.status,
  });

  factory RoundModel.fromJson(Map<String, dynamic> json) {
    return RoundModel(
      id: json["id"],
      roundNumber: json["roundNumber"],
      status: json["status"],
    );
  }
}