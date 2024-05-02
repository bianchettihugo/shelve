import 'package:shelve/core/services/tagging/tagging.service.dart';

class TaggingMockService extends TaggingService {
  @override
  Future<void> logEvent(String name, Map<String, dynamic> parameters) async {}

  @override
  Future<void> setCurrentScreen(String screenName) async {}
}
