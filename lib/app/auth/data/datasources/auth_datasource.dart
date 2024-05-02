import '../models/user_model.dart';

abstract class AuthDataSource {
  Future<UserModel> login({
    required String email,
    required String password,
  });

  Future<bool> register({
    required String username,
    required String email,
    required String password,
  });

  Future<void> logout();
}
