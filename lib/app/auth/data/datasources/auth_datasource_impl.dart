import 'package:shelve/app/auth/data/datasources/auth_datasource.dart';
import 'package:shelve/app/auth/data/models/user_model.dart';
import 'package:shelve/core/services/auth/auth_service.dart';

class AuthDatasourceImpl extends AuthDataSource {
  final AuthService _authService;

  AuthDatasourceImpl({required AuthService authService})
      : _authService = authService;

  @override
  Future<UserModel> login(
      {required String email, required String password}) async {
    final user = await _authService.signIn(
      email: email,
      password: password,
    );

    return UserModel(
      id: user['id'] ?? '',
      email: user['email'],
      name: user['user'],
      photoUrl: '',
    );
  }

  @override
  Future<void> logout() async {
    await _authService.signOut();
  }

  @override
  Future<bool> register({
    required String username,
    required String email,
    required String password,
  }) async {
    await _authService.signUp(
      username: username,
      email: email,
      password: password,
    );

    return true;
  }
}
