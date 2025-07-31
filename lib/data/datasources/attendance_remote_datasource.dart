import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scb_attendance_app/data/models/attendace_model.dart';

abstract class AttendanceRemoteDataSource {
  Future<void> checkIn(String userId);
  Future<void> checkOut(String userId);
  Future<List<AttendanceModel>> getUserAttendance(String userId);
  Future<List<AttendanceModel>> getAllUsersAttendance();
}

class AttendanceRemoteDataSourceImpl implements AttendanceRemoteDataSource {
  final FirebaseFirestore firestore;

  AttendanceRemoteDataSourceImpl({required this.firestore});

  @override
  Future<void> checkIn(String userId) async {
    final today = DateTime.now();
    final docId = "${userId}_${today.toIso8601String().substring(0, 10)}";

    await firestore.collection('attendance').doc(docId).set({
      'userId': userId,
      'date': today.toIso8601String().substring(0, 10),
      'checkInTime': DateTime.now().toIso8601String(),
      'checkOutTime': null,
    });
  }

  @override
  Future<void> checkOut(String userId) async {
    final today = DateTime.now().toIso8601String().substring(0, 10);
    final docId = "${userId}_$today";

    await firestore.collection('attendance').doc(docId).update({
      'checkOutTime': DateTime.now().toIso8601String(),
    });
  }

  @override
  Future<List<AttendanceModel>> getUserAttendance(String userId) async {
    final snapshot = await firestore
        .collection('attendance')
        .where('userId', isEqualTo: userId)
        .get();

    return snapshot.docs
        .map((doc) => AttendanceModel.fromMap(doc.data(), doc.id))
        .toList();
  }

  @override
  Future<List<AttendanceModel>> getAllUsersAttendance() async {
    final snapshot = await firestore.collection('attendance').get();

    return snapshot.docs
        .map((doc) => AttendanceModel.fromMap(doc.data(), doc.id))
        .toList();
  }
}
