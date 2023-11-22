import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:scoring_pad/presentation/screens/BoardGamesScreen.dart';
import 'package:scoring_pad/presentation/screens/CardGamesScreen.dart';
import 'package:scoring_pad/presentation/screens/DiceGamesScreen.dart';
import 'package:scoring_pad/presentation/screens/GameCategoryScreen.dart';

import 'presentation/screens/main_screen.dart';

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const GameCategoryScreen(),
      ),
    ),
    GoRoute(
      path: '/dice-games',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const DiceGamesScreen(),
      ),
    ),
    GoRoute(
      path: '/card-games',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const CardGamesScreen(),
      ),
    ),
    GoRoute(
      path: '/board-games',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const BoardGamesScreen(),
      ),
    ),
  ],
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
