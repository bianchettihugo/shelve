import 'package:shelve/app/auth/domain/entities/user_entity.dart';

import '../../../../core/services/tagging/tagging.service.dart';
import '../../../../core/utils/result.dart';
import '../errors/auth_error.dart';
import '../repositories/auth_repository.dart';

abstract class SigninUsecase {
  Future<Result<AuthError, UserEntity>> call({
    required String email,
    required String password,
  });
}

class SigninUsecaseImpl implements SigninUsecase {
  final AuthRepository _repository;
  final TaggingService _taggingService;

  SigninUsecaseImpl({
    required AuthRepository repository,
    required TaggingService taggingService,
  })  : _repository = repository,
        _taggingService = taggingService;

  @override
  Future<Result<AuthError, UserEntity>> call({
    required String email,
    required String password,
  }) async {
    final result = await _repository.login(email: email, password: password);

    if (result.isSuccess) {
      _taggingService.logEvent('login', {
        'email': email,
      });
    } else {
      _taggingService.logEvent('login_failed', {
        'email': email,
        'error': result.error.toString(),
      });
    }

    return result;
  }
}
