import 'package:equatable/equatable.dart';
import 'package:scb_attendance_app/domain/entities/attendance_entity.dart';

abstract class AttendanceState extends Equatable {
  const AttendanceState();

  @override
  List<Object?> get props => [];
}

class AttendanceInitial extends AttendanceState {}

class AttendanceLoading extends AttendanceState {}

class AttendanceSuccess extends AttendanceState {}

class AttendanceLoaded extends AttendanceState {
  final List<AttendanceEntity> attendance;

  const AttendanceLoaded(this.attendance);

  @override
  List<Object?> get props => [attendance];
}

class AllAttendanceLoaded extends AttendanceState {
  final List<AttendanceEntity> allAttendance;

  const AllAttendanceLoaded(this.allAttendance);

  @override
  List<Object?> get props => [allAttendance];
}

class AttendanceError extends AttendanceState {
  final String message;

  const AttendanceError(this.message);

  @override
  List<Object?> get props => [message];
}
