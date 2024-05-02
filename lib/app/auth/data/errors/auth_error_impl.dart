import '../../domain/errors/auth_error.dart';

class AuthErrorImpl extends AuthError {
  AuthErrorImpl({
    super.title = '',
    super.message = '',
    super.id = 0,
  });

  factory AuthErrorImpl.defaultError() {
    return AuthErrorImpl(
      id: -1,
    );
  }

  factory AuthErrorImpl.invalidCredentials() {
    return AuthErrorImpl(
      id: 0,
    );
  }

  factory AuthErrorImpl.notConfirmed() {
    return AuthErrorImpl(
      id: 1,
    );
  }

  factory AuthErrorImpl.alreadyRegistered() {
    return AuthErrorImpl(
      id: 2,
    );
  }
}
