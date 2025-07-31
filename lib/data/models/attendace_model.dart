class AttendanceModel {
  final String id; // Firestore document ID
  final String userId;
  final DateTime date;
  final DateTime? checkInTime;
  final DateTime? checkOutTime;

  AttendanceModel({
    required this.id,
    required this.userId,
    required this.date,
    this.checkInTime,
    this.checkOutTime,
  });

  factory AttendanceModel.fromMap(Map<String, dynamic> map, String documentId) {
    return AttendanceModel(
      id: documentId,
      userId: map['userId'] ?? '',
      date: DateTime.parse(map['date']),
      checkInTime: map['checkInTime'] != null
          ? DateTime.parse(map['checkInTime'])
          : null,
      checkOutTime: map['checkOutTime'] != null
          ? DateTime.parse(map['checkOutTime'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'date': date.toIso8601String(),
      'checkInTime': checkInTime?.toIso8601String(),
      'checkOutTime': checkOutTime?.toIso8601String(),
    };
  }
}

