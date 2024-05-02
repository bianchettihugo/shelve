import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shelve/app/auth/auth_module.dart';
import 'package:shelve/core/theme/light_theme.dart';
import 'package:shelve/shelve_app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app/category/category_module.dart';
import 'core/services/auth/auth_service.dart';
import 'core/services/auth/auth_service_supabase.dart';
import 'core/services/dependency/dependency_service.dart';
import 'core/services/storage/local_storage.service.dart';
import 'core/services/storage/local_storage_sp.service.dart';
import 'core/services/tagging/tagging.service.dart';
import 'core/services/tagging/tagging_mock.service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
    url: dotenv.env["SUPABASE_URL"]!,
    anonKey: dotenv.env["SUPABASE_ANON_KEY"]!,
  );

  final sharedPreferences = await SharedPreferences.getInstance();
  Dependency.register<LocalStorageService>(
    LocalStorageSPService(sharedPreferences),
  );
  Dependency.register<AuthService>(
    AuthServiceSupabase(),
  );

  Dependency.register<TaggingService>(
    TaggingMockService(),
  );

  AuthModule.init();
  CategoryModule.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'NoteZ',
      locale: const Locale('en'),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: LightTheme.theme,
      routerConfig: ShelveApp.router,
    );
  }
}
