import 'package:scb_attendance_app/domain/entities/user_entity.dart';
import 'package:scb_attendance_app/domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  UserEntity _mapToEntity(UserModel model) {
    return UserEntity(
      id: model.id,
      name: model.name,
      email: model.email,
      role: model.role,
    );
  }

  @override
  Future<UserEntity> login(String email, String password) async {
    final userModel = await remoteDataSource.Login(email, password);
    return _mapToEntity(userModel);
  }

  @override
  Future<UserEntity> register(
    String name,
    String email,
    String password,
  ) async {
    final userModel = await remoteDataSource.register(name, email, password);
    return _mapToEntity(userModel);
  }

  @override
  Future<UserEntity> getCurrentUser() async {
    final userModel = await remoteDataSource.getCurrentUser();
    return _mapToEntity(userModel);
  }

  @override
  Future<void> signOut() async {
    await remoteDataSource.signOut();
  }
}
