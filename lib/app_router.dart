import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:scoring_pad/domain/entities/game_category.dart';
import 'package:scoring_pad/presentation/screens/favorite_games_screen.dart';
import 'package:scoring_pad/presentation/screens/game_categories_screen.dart';
import 'package:scoring_pad/presentation/screens/games_screen.dart';
import 'package:scoring_pad/presentation/screens/main_screen.dart';
import 'package:scoring_pad/presentation/screens/players_selection_screen.dart';

class AppRouter {
  // all the route paths. So that we can access them easily across the app
  static const root = '/';

  static final GoRouter _router = GoRouter(
    routes: <GoRoute>[
      GoRoute(path: root, pageBuilder: _createBuilder(const MainScreen())),
      GoRoute(path: GamesScreen.path, pageBuilder: _createBuilder(const GameCategoriesScreen())),
      GoRoute(
        path: '${GamesScreen.path}/:category',
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: GamesScreen(
            category: GameCategory.getFromString(state.pathParameters["category"]),
          ),
        ),
      ),
      GoRoute(path: FavoriteGamesScreen.path, pageBuilder: _createBuilder(const FavoriteGamesScreen())),
      GoRoute(path: PlayersSelectionScreen.path, pageBuilder: _createBuilder(const PlayersSelectionScreen())),
    ],
  );

  static GoRouter get router => _router;

  static GoRouterPageBuilder _createBuilder(Widget widget) {
    return (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: widget,
        );
  }
}
