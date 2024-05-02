abstract class TaggingService {
  Future<void> logEvent(String name, Map<String, dynamic> parameters);
  Future<void> setCurrentScreen(String screenName);
}
