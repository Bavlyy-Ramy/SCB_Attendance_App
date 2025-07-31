import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scb_attendance_app/domain/usecases/attendance%20usecases/check_in_usecase.dart';
import 'package:scb_attendance_app/domain/usecases/attendance%20usecases/check_out_usecase.dart';
import 'package:scb_attendance_app/domain/usecases/attendance%20usecases/get_all_attendance_usecase.dart';
import 'package:scb_attendance_app/domain/usecases/attendance%20usecases/get_user_attendance_usecase.dart';
import 'package:scb_attendance_app/domain/usecases/auth%20usecases/get_current_user_usecase.dart';
import 'package:scb_attendance_app/domain/usecases/auth%20usecases/login_usecase.dart';
import 'package:scb_attendance_app/domain/usecases/auth%20usecases/register_usecase.dart';
import 'package:scb_attendance_app/domain/usecases/auth%20usecases/sign_out_usecase.dart';

import 'data/datasources/auth_remote_datasource.dart';
import 'data/datasources/attendance_remote_datasource.dart';
import 'data/repositories_impl/auth_repository_impl.dart';
import 'data/repositories_impl/attendance_repository_impl.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/repositories/attendance_repository.dart';


final sl = GetIt.instance;

Future<void> init() async {
  // ✅ Firebase instances
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);

  // ✅ Data Sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      firebaseAuth: sl(),
      firestore: sl(),
    ),
  );

  sl.registerLazySingleton<AttendanceRemoteDataSource>(
    () => AttendanceRemoteDataSourceImpl(
      firestore: sl(),
    ),
  );

  // ✅ Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl()),
  );

  sl.registerLazySingleton<AttendanceRepository>(
    () => AttendanceRepositoryImpl(remoteDataSource: sl()),
  );

  // ✅ Auth Use Cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => GetCurrentUserUseCase(sl()));
  sl.registerLazySingleton(() => SignOutUseCase(sl()));

  // ✅ Attendance Use Cases
  sl.registerLazySingleton(() => CheckInUseCase(sl()));
  sl.registerLazySingleton(() => CheckOutUseCase(sl()));
  sl.registerLazySingleton(() => GetUserAttendanceUseCase(sl()));
  sl.registerLazySingleton(() => GetAllAttendanceUseCase(sl()));
}
