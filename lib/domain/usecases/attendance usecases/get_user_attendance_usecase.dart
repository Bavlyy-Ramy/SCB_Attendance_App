import 'package:scb_attendance_app/domain/entities/attendance_entity.dart';
import 'package:scb_attendance_app/domain/repositories/attendance_repository.dart';

class GetUserAttendanceUseCase {
  final AttendanceRepository repository;

  GetUserAttendanceUseCase(this.repository);

  Future<List<AttendanceEntity>> call(String userId) {
    return repository.getUserAttendance(userId);
  }
}
