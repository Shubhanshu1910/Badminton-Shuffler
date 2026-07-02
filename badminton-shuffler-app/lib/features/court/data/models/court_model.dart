class CourtModel {
  final String id;
  final String name;
  final int courtNumber;
  final String status;
  final bool isActive;

  CourtModel({
    required this.id,
    required this.name,
    required this.courtNumber,
    required this.status,
    required this.isActive,
  });

  factory CourtModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return CourtModel(
      id: json['id'],
      name: json['name'],
      courtNumber: json['courtNumber'],
      status: json['status'],
      isActive: json['isActive'],
    );
  }
}