import 'package:shelve/app/auth/data/datasources/auth_datasource.dart';
import 'package:shelve/app/auth/data/errors/auth_error_impl.dart';
import 'package:shelve/app/auth/domain/entities/user_entity.dart';
import 'package:shelve/app/auth/domain/errors/auth_error.dart';
import 'package:shelve/app/auth/domain/repositories/auth_repository.dart';
import 'package:shelve/core/utils/result.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDataSource _authDataSource;

  AuthRepositoryImpl({required AuthDataSource authDataSource})
      : _authDataSource = authDataSource;

  @override
  Future<Result<AuthError, UserEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _authDataSource.login(
        email: email,
        password: password,
      );
      return Result.success(
        result.toEntity(),
      );
    } on AuthException catch (e) {
      if (e.message.contains('Invalid login')) {
        return Result.failure(AuthErrorImpl.invalidCredentials());
      } else if (e.message.contains('Email not confirmed')) {
        return Result.failure(AuthErrorImpl.notConfirmed());
      } else if (e.message.contains('User already registered')) {
        return Result.failure(AuthErrorImpl.alreadyRegistered());
      } else {
        return Result.failure(AuthErrorImpl.defaultError());
      }
    } catch (e) {
      return Result.failure(AuthErrorImpl.defaultError());
    }
  }

  @override
  Future<bool> logout() async {
    try {
      await _authDataSource.logout();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Result<AuthError, bool>> register({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      await _authDataSource.register(
        username: username,
        email: email,
        password: password,
      );
      return Result.success(true);
    } on AuthException catch (e) {
      if (e.message.contains('Invalid login')) {
        return Result.failure(AuthErrorImpl.invalidCredentials());
      } else if (e.message.contains('Email not confirmed')) {
        return Result.failure(AuthErrorImpl.notConfirmed());
      } else if (e.message.contains('User already registered')) {
        return Result.failure(AuthErrorImpl.alreadyRegistered());
      } else {
        return Result.failure(AuthErrorImpl.defaultError());
      }
    } catch (e) {
      return Result.failure(AuthErrorImpl.defaultError());
    }
  }
}
