import 'package:scb_attendance_app/domain/repositories/attendance_repository.dart';


class CheckInUseCase {
  final AttendanceRepository repository;

  CheckInUseCase(this.repository);

  Future<void> call(String userId) {
    return repository.checkIn(userId);
  }
}
