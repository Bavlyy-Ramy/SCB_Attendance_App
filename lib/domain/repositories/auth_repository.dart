import '../entities/user_entity.dart';

abstract class AuthRepository {
  /// Login existing user
  Future<UserEntity> login(String email, String password);

  /// Register a new user
Future<UserEntity> register(String name, String email, String password, String role);

  /// Get current logged-in user
  Future<UserEntity> getCurrentUser();

  /// Sign out user
  Future<void> signOut();
}
