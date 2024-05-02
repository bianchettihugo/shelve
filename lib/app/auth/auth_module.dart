import 'package:shelve/app/auth/data/datasources/auth_datasource.dart';
import 'package:shelve/app/auth/data/datasources/auth_datasource_impl.dart';
import 'package:shelve/app/auth/data/repositories/auth_repository_impl.dart';
import 'package:shelve/app/auth/domain/repositories/auth_repository.dart';
import 'package:shelve/app/auth/domain/usecases/logout_usecase.dart';
import 'package:shelve/app/auth/domain/usecases/signin_usecase.dart';
import 'package:shelve/app/auth/domain/usecases/signup_usecase.dart';
import 'package:shelve/app/auth/presenter/controller/auth_controller.dart';
import 'package:shelve/core/services/auth/auth_service.dart';
import 'package:shelve/core/services/tagging/tagging.service.dart';

import '../../core/services/dependency/dependency_service.dart';

class AuthModule {
  static void init() {
    Dependency.register<AuthDataSource>(
      AuthDatasourceImpl(
        authService: Dependency.get<AuthService>(),
      ),
    );

    Dependency.register<AuthRepository>(
      AuthRepositoryImpl(
        authDataSource: Dependency.get<AuthDataSource>(),
      ),
    );

    Dependency.register<SigninUsecase>(
      SigninUsecaseImpl(
        repository: Dependency.get<AuthRepository>(),
        taggingService: Dependency.get<TaggingService>(),
      ),
    );

    Dependency.register<SignupUsecase>(
      SignupUsecaseImpl(
        repository: Dependency.get<AuthRepository>(),
        taggingService: Dependency.get<TaggingService>(),
      ),
    );

    Dependency.register<LogoutUsecase>(
      LogoutUsecaseImpl(
        repository: Dependency.get<AuthRepository>(),
        taggingService: Dependency.get<TaggingService>(),
      ),
    );

    Dependency.register<AuthController>(
      AuthController(
        signinUsecase: Dependency.get<SigninUsecase>(),
        signupUsecase: Dependency.get<SignupUsecase>(),
        logoutUsecase: Dependency.get<LogoutUsecase>(),
      ),
    );
  }
}
