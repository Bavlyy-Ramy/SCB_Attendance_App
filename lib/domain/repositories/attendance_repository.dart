import '../entities/attendance_entity.dart';

abstract class AttendanceRepository {
  Future<void> checkIn(String userId);
  Future<void> checkOut(String userId);
  Future<List<AttendanceEntity>> getUserAttendance(String userId);
  Future<List<AttendanceEntity>> getAllUsersAttendance();
}
