import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:shelve/shelve_app.dart';

class Dependency {
  static T get<T extends Object>([String? tag]) {
    return GetIt.I.get<T>(instanceName: tag);
  }

  static T? getOrNull<T extends Object>([String? tag]) {
    try {
      return GetIt.I.get<T>(instanceName: tag);
    } catch (e) {
      return null;
    }
  }

  static void register<T extends Object>(T instance) {
    GetIt.I.registerSingleton<T>(instance);
  }

  static void registerLazy<T extends Object>(T instance) {
    return GetIt.I.registerLazySingleton<T>(() => instance);
  }

  static void registerFactory<T extends Object>(T Function() instance,
      [String? tag]) {
    if (GetIt.I.isRegistered<T>(instanceName: tag)) {
      GetIt.I.unregister<T>(instanceName: tag);
    }
    return GetIt.I.registerFactory(instance, instanceName: tag);
  }

  static AppLocalizations get strings =>
      AppLocalizations.of(ShelveApp.navigatorKey.currentContext!)!;
}
