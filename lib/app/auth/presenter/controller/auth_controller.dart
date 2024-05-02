import 'package:go_router/go_router.dart';
import 'package:shelve/app/auth/domain/entities/user_entity.dart';
import 'package:shelve/app/auth/domain/usecases/signin_usecase.dart';
import 'package:shelve/app/auth/domain/usecases/signup_usecase.dart';
import 'package:shelve/core/utils/dialogs.dart';
import 'package:shelve/shelve_app.dart';

import '../../../../core/services/dependency/dependency_service.dart';
import '../../../../core/values/routes.dart';
import '../../domain/errors/auth_error.dart';
import '../../domain/usecases/logout_usecase.dart';

class AuthController {
  UserEntity? user;
  final SigninUsecase _signinUsecase;
  final SignupUsecase _signupUsecase;
  final LogoutUsecase _logoutUsecase;

  AuthController({
    required SigninUsecase signinUsecase,
    required SignupUsecase signupUsecase,
    required LogoutUsecase logoutUsecase,
  })  : _signinUsecase = signinUsecase,
        _signupUsecase = signupUsecase,
        _logoutUsecase = logoutUsecase;

  void _showErrorMessage(AuthError error) {
    String title = '';
    String message = '';

    switch (error.id) {
      case 0:
        title = Dependency.strings.invalidCredentials;
        message = Dependency.strings.invalidCredentialsMessage;
        break;
      case 1:
        title = Dependency.strings.emailNotVerified;
        message = Dependency.strings.emailNotVerifiedMessage;
        break;
      case 2:
        title = Dependency.strings.emailAlreadyInUse;
        message = Dependency.strings.emailAlreadyInUseMessage;
        break;
      default:
        title = Dependency.strings.loginFailed;
        message = Dependency.strings.loginFailedMessage;
        break;
    }
    Future.delayed(const Duration(milliseconds: 290), () {
      showErrorDialog(
        title: title,
        message: message,
      );
    });
  }

  Future<void> signIn({required String email, required String password}) async {
    final result = await _signinUsecase(
      email: email,
      password: password,
    );

    result.when(
      success: (user) async {
        this.user = user;
        await Future.delayed(const Duration(milliseconds: 200));
        goHome();
      },
      failure: _showErrorMessage,
    );
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    final result = await _signupUsecase(
      email: email,
      password: password,
      username: name,
    );

    result.when(
      success: (data) {
        Future.delayed(const Duration(milliseconds: 290), () {
          showSuccessDialog(
            title: Dependency.strings.emailVerificationSent,
            message: Dependency.strings.emailVerificationSentMessage,
          ).then((value) {
            final app = ShelveApp();
            app.context.pop();
          });
        });
      },
      failure: _showErrorMessage,
    );
  }

  Future<void> goHome() async {
    final app = ShelveApp();
    app.context.pushNamed(
      Routes.dashboard,
    );
  }

  Future<void> logout() async {
    final app = ShelveApp();
    final result = await _logoutUsecase();

    if (result && app.context.mounted) {
      app.context.pushReplacementNamed(
        Routes.auth,
      );
    }
  }
}
