import 'package:scb_attendance_app/data/models/attendace_model.dart';
import 'package:scb_attendance_app/domain/entities/attendance_entity.dart';
import 'package:scb_attendance_app/domain/repositories/attendance_repository.dart';
import '../datasources/attendance_remote_datasource.dart';

class AttendanceRepositoryImpl implements AttendanceRepository {
  final AttendanceRemoteDataSource remoteDataSource;

  AttendanceRepositoryImpl({required this.remoteDataSource});

 AttendanceEntity _mapToEntity(AttendanceModel model) {
  return AttendanceEntity(
    id: model.id,
    userId: model.userId,
    date: model.date,
    checkInTime: model.checkInTime, // ✅ Already nullable
    checkOutTime: model.checkOutTime, // ✅ Already nullable
  );
}


  @override
  Future<void> checkIn(String userId) async {
    await remoteDataSource.checkIn(userId);
  }

  @override
  Future<void> checkOut(String userId) async {
    await remoteDataSource.checkOut(userId);
  }

@override
Future<List<AttendanceEntity>> getUserAttendance(String userId) async {
  final models = await remoteDataSource.getUserAttendance(userId);

  // ✅ Convert List<AttendanceModel> → List<AttendanceEntity>
  return models.map((model) => AttendanceEntity(
        id: model.id,
        userId: model.userId,
        date: model.date,
        checkInTime: model.checkInTime,
        checkOutTime: model.checkOutTime,
      )).toList();
}

@override
Future<List<AttendanceEntity>> getAllUsersAttendance() async {
  final models = await remoteDataSource.getAllUsersAttendance();

  return models.map((model) => AttendanceEntity(
        id: model.id,
        userId: model.userId,
        date: model.date,
        checkInTime: model.checkInTime,
        checkOutTime: model.checkOutTime,
      )).toList();
}

}
