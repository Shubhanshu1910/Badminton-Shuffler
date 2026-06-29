class SessionModel {
  final String id;
  final String title;
  final String status;
  final int totalCourts;
  final int currentRound;

  SessionModel({
    required this.id,
    required this.title,
    required this.status,
    required this.totalCourts,
    required this.currentRound,
  });

  factory SessionModel.fromJson(Map<String, dynamic> json) {
    return SessionModel(
      id: json['id'],
      title: json['title'],
      status: json['status'],
      totalCourts: json['totalCourts'],
      currentRound: json['currentRound'],
    );
  }
}