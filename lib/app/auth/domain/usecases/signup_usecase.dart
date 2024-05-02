import '../../../../core/services/tagging/tagging.service.dart';
import '../../../../core/utils/result.dart';
import '../errors/auth_error.dart';
import '../repositories/auth_repository.dart';

abstract class SignupUsecase {
  Future<Result<AuthError, bool>> call({
    required String username,
    required String email,
    required String password,
  });
}

class SignupUsecaseImpl implements SignupUsecase {
  final AuthRepository _repository;
  final TaggingService _taggingService;

  SignupUsecaseImpl({
    required AuthRepository repository,
    required TaggingService taggingService,
  })  : _repository = repository,
        _taggingService = taggingService;

  @override
  Future<Result<AuthError, bool>> call({
    required String username,
    required String email,
    required String password,
  }) async {
    final result = await _repository.register(
      email: email,
      password: password,
      username: username,
    );

    if (result.isSuccess) {
      _taggingService.logEvent('signup', {
        'email': email,
      });
    } else {
      _taggingService.logEvent('signup_failed', {
        'email': email,
        'error': result.error.toString(),
      });
    }

    return result;
  }
}
