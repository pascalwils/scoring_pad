import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:scoring_pad/presentation/screens/rules_screen.dart';
import 'package:talker/talker.dart';

import 'models/game_category.dart';
import 'presentation/screens/about_screen.dart';
import 'presentation/screens/favorite_games_screen.dart';
import 'presentation/screens/game_categories_screen.dart';
import 'presentation/screens/games_list_screen.dart';
import 'presentation/screens/games_screen.dart';
import 'presentation/screens/main_screen.dart';
import 'presentation/screens/players_list_screen.dart';
import 'presentation/screens/players_selection/player_selection_screen.dart';
import 'presentation/screens/game_settings/game_settings_screen.dart';
import 'presentation/screens/game_start_screen.dart';
import 'presentation/screens/player_details_screen.dart';
import 'presentation/screens/settings_screen.dart';
import 'presentation/screens/skull_king/skull_king_round_edit_screen.dart';
import 'presentation/screens/skull_king/skull_king_round_screen.dart';
import 'presentation/screens/skull_king/skull_king_end_screen.dart';
import 'presentation/screens/standard_game/standard_game_round_edit_screen.dart';
import 'presentation/screens/standard_game/standard_game_round_screen.dart';

final talker = Talker();

class AppRouter {
  // all the route paths. So that we can access them easily across the app
  static const root = '/';

  static final GoRouter _router = GoRouter(
    initialLocation: root,
    routes: [
      GoRoute(
        path: root,
        pageBuilder: _createBuilder(const MainScreen()),
        routes: [
          GoRoute(
            path: PlayersListScreen.path,
            pageBuilder: _createBuilder(const PlayersListScreen()),
            routes: [
              GoRoute(
                path: PlayerDetailsScreen.path,
                pageBuilder: _createBuilder(const PlayerDetailsScreen()),
              ),
            ],
          ),
          GoRoute(
            path: GamesListScreen.path,
            pageBuilder: _createBuilder(const GamesListScreen()),
          ),
          GoRoute(path: SettingsScreen.path, pageBuilder: _createBuilder(const SettingsScreen())),
          GoRoute(path: AboutScreen.path, pageBuilder: _createBuilder(const AboutScreen())),
        ],
      ),
      GoRoute(
        path: GameCategoriesScreen.path,
        pageBuilder: _createBuilder(const GameCategoriesScreen()),
        routes: [
          GoRoute(
            path: FavoriteGamesScreen.path,
            pageBuilder: _createBuilder(const FavoriteGamesScreen()),
          ),
          GoRoute(
            path: '${GamesScreen.path}/:category',
            pageBuilder: (context, state) => NoTransitionPage<void>(
              key: state.pageKey,
              child: GamesScreen(
                category: GameCategory.getFromString(state.pathParameters["category"]),
              ),
            ),
          ),
        ],
      ),
      GoRoute(
        path: GameStartScreen.path,
        pageBuilder: _createBuilder(const GameStartScreen()),
        routes: [
          GoRoute(
            path: '${PlayerSelectionScreen.path}/:nbMin/:nbMax',
            pageBuilder: (context, state) {
              final nbMin = int.parse(state.pathParameters["nbMin"]!);
              final nbMax = int.parse(state.pathParameters["nbMax"]!);
              talker.debug("Going to player selection screen with [$nbMin,$nbMax]");
              return NoTransitionPage<void>(
                key: state.pageKey,
                child: PlayerSelectionScreen(minPlayers: nbMin, maxPlayers: nbMax),
              );
            },
          ),
          GoRoute(
            path: RulesScreen.path,
            pageBuilder: _createBuilder(const RulesScreen()),
          ),
          GoRoute(
            path: GameSettingsScreen.path,
            pageBuilder: _createBuilder(const GameSettingsScreen()),
          ),
        ],
      ),
      GoRoute(
        path: SkullKingRoundScreen.path,
        pageBuilder: _createBuilder(const SkullKingRoundScreen()),
        routes: [
          GoRoute(
            path: '${SkullKingRoundEditScreen.path}/:roundIndex',
            pageBuilder: (context, state) {
              final index = int.parse(state.pathParameters["roundIndex"]!);
              talker.debug("Going to skull king round #$index edit screen");
              return CustomTransitionPage<void>(
                key: state.pageKey,
                child: SkullKingRoundEditScreen(roundIndex: index),
                transitionsBuilder: (_, animation, __, child) => SlideTransition(
                  position: animation.drive(
                    Tween<Offset>(
                      begin: const Offset(0.0, 1.0),
                      end: Offset.zero,
                    ).chain(CurveTween(curve: Curves.easeIn)),
                  ),
                  child: child,
                ),
              );
            },
          ),
        ],
      ),
      GoRoute(
        path: SkullKingEndScreen.path,
        pageBuilder: (context, state) {
          return CustomTransitionPage<void>(
            key: state.pageKey,
            child: SkullKingEndScreen(),
            transitionsBuilder: (_, animation, __, child) => SlideTransition(
              position: animation.drive(
                Tween<Offset>(
                  begin: const Offset(1.0, 0),
                  end: Offset.zero,
                ).chain(CurveTween(curve: Curves.easeIn)),
              ),
              child: child,
            ),
          );
        },
      ),
      GoRoute(
        path: StandardGameRoundScreen.path,
        pageBuilder: _createBuilder(const StandardGameRoundScreen()),
        routes: [
          GoRoute(
            path: '${StandardGameRoundEditScreen.path}/:roundIndex',
            pageBuilder: (context, state) {
              final index = int.parse(state.pathParameters["roundIndex"]!);
              talker.debug("Going to standard game round #$index edit screen");
              return CustomTransitionPage<void>(
                key: state.pageKey,
                child: StandardGameRoundEditScreen(roundIndex: index),
                transitionsBuilder: (_, animation, __, child) => SlideTransition(
                  position: animation.drive(
                    Tween<Offset>(
                      begin: const Offset(0.0, 1.0),
                      end: Offset.zero,
                    ).chain(CurveTween(curve: Curves.easeIn)),
                  ),
                  child: child,
                ),
              );
            },
          ),
        ],
      ),
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
