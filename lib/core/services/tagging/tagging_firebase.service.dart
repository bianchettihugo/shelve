import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:shelve/core/services/tagging/tagging.service.dart';

class TaggingFirebaseService extends TaggingService {
  final FirebaseAnalytics _analytics;

  TaggingFirebaseService() : _analytics = FirebaseAnalytics.instance;

  @override
  Future<void> logEvent(String name, Map<String, dynamic> parameters) async {
    await _analytics.logEvent(name: name, parameters: parameters);
  }

  @override
  Future<void> setCurrentScreen(String screenName) async {
    await _analytics.logScreenView(screenName: screenName);
  }
}
