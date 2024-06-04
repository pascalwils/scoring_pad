import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pref/pref.dart';

import 'app_router.dart';
import 'data/datasource.dart';
import 'settings/pref_init.dart';
import 'settings/pref_keys.dart';
import 'settings/pref_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDatasource();

  final service = await prefServiceInit();

  runApp(
    PrefService(
      service: service,
      child: const ProviderScope(child: MyApp()),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = _getBrightness(context);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: brightness,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(PrefService.of(context).get(uiColorPrefKey)),
          brightness: brightness,
        ),
      ),
      routerConfig: AppRouter.router,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }

  Brightness _getBrightness(BuildContext context) {
    switch (PrefTheme.fromPreferences(context)) {
      case PrefTheme.light:
        return Brightness.light;
      case PrefTheme.dark:
        return Brightness.dark;
      default:
        return MediaQuery.of(context).platformBrightness;
    }
  }
}
