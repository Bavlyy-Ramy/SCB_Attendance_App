import 'package:scb_attendance_app/domain/entities/attendance_entity.dart';
import 'package:scb_attendance_app/domain/repositories/attendance_repository.dart';


class GetAllAttendanceUseCase {
  final AttendanceRepository repository;

  GetAllAttendanceUseCase(this.repository);

  Future<List<AttendanceEntity>> call() {
    return repository.getAllUsersAttendance();
  }
}
