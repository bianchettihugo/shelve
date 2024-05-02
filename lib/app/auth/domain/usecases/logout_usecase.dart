import '../../../../core/services/tagging/tagging.service.dart';
import '../repositories/auth_repository.dart';

abstract class LogoutUsecase {
  Future<bool> call();
}

class LogoutUsecaseImpl implements LogoutUsecase {
  final AuthRepository _repository;
  final TaggingService _taggingService;

  LogoutUsecaseImpl({
    required AuthRepository repository,
    required TaggingService taggingService,
  })  : _repository = repository,
        _taggingService = taggingService;

  @override
  Future<bool> call() async {
    final result = await _repository.logout();

    if (result) {
      _taggingService.logEvent('logout', {});
    } else {
      _taggingService.logEvent('logout_failed', {});
    }

    return result;
  }
}
