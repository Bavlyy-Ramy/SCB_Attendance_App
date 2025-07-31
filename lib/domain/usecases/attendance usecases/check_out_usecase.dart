import 'package:scb_attendance_app/domain/repositories/attendance_repository.dart';



class CheckOutUseCase {
  final AttendanceRepository repository;

  CheckOutUseCase(this.repository);

  Future<void> call(String userId) {
    return repository.checkOut(userId);
  }
}
