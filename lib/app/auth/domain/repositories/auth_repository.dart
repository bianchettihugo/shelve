import 'package:shelve/app/auth/domain/entities/user_entity.dart';
import 'package:shelve/core/utils/result.dart';

import '../errors/auth_error.dart';

abstract class AuthRepository {
  Future<Result<AuthError, UserEntity>> login({
    required String email,
    required String password,
  });

  Future<Result<AuthError, bool>> register({
    required String username,
    required String email,
    required String password,
  });

  Future<bool> logout();
}
