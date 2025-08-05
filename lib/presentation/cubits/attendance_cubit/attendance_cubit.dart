import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scb_attendance_app/domain/entities/attendance_entity.dart';
import 'package:scb_attendance_app/domain/usecases/attendance%20usecases/check_in_usecase.dart';
import 'package:scb_attendance_app/domain/usecases/attendance%20usecases/check_out_usecase.dart';
import 'package:scb_attendance_app/domain/usecases/attendance%20usecases/get_all_attendance_usecase.dart';
import 'package:scb_attendance_app/domain/usecases/attendance%20usecases/get_user_attendance_usecase.dart';

import 'attendance_state.dart';

class AttendanceCubit extends Cubit<AttendanceState> {
  final CheckInUseCase checkInUseCase;
  final CheckOutUseCase checkOutUseCase;
  final GetUserAttendanceUseCase getUserAttendanceUseCase;
  final GetAllAttendanceUseCase getAllUsersAttendanceUseCase;

  AttendanceCubit({
    required this.checkInUseCase,
    required this.checkOutUseCase,
    required this.getUserAttendanceUseCase,
    required this.getAllUsersAttendanceUseCase,
  }) : super(AttendanceInitial());

  Future<void> checkIn(String userId) async {
    emit(AttendanceLoading());
    try {
      await checkInUseCase(userId);
      emit(AttendanceSuccess());
    } catch (e) {
      emit(AttendanceError("Failed to clock in: ${e.toString()}"));
    }
  }

  Future<void> checkOut(String userId) async {
    emit(AttendanceLoading());
    try {
      await checkOutUseCase(userId);
      emit(AttendanceSuccess());
    } catch (e) {
      emit(AttendanceError("Failed to clock out: ${e.toString()}"));
    }
  }

  Future<void> getUserAttendance(String userId) async {
    emit(AttendanceLoading());
    try {
      final result = await getUserAttendanceUseCase(userId);
      emit(AttendanceLoaded(result));
    } catch (e) {
      emit(AttendanceError("Failed to load attendance: ${e.toString()}"));
    }
  }

  Future<void> getAllAttendance() async {
    emit(AttendanceLoading());
    try {
      final result = await getAllUsersAttendanceUseCase();
      emit(AllAttendanceLoaded(result));
    } catch (e) {
      emit(AttendanceError("Failed to load all users' attendance: ${e.toString()}"));
    }
  }
}
