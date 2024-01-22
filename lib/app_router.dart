import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:scoring_pad/presentation/screens/player_details_screen.dart';
import 'package:scoring_pad/presentation/screens/settings_screen.dart';

import 'domain/entities/game_category.dart';
import 'presentation/screens/favorite_games_screen.dart';
import 'presentation/screens/game_categories_screen.dart';
import 'presentation/screens/games_screen.dart';
import 'presentation/screens/main_screen.dart';
import 'presentation/screens/players_list_screen.dart';
import 'presentation/screens/players_selection/player_selection_screen.dart';

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
      GoRoute(path: PlayerSelectionScreen.path, pageBuilder: _createBuilder(const PlayerSelectionScreen())),
      GoRoute(path: PlayersListScreen.path, pageBuilder: _createBuilder(const PlayersListScreen())),
      GoRoute(path: PlayerDetailsScreen.path, pageBuilder: _createBuilder(const PlayerDetailsScreen())),
      GoRoute(path: SettingsScreen.path, pageBuilder: _createBuilder(const SettingsScreen())),
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
