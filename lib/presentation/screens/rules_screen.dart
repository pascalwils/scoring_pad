import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:scoring_pad/game_engines/game_engine.dart';
import 'package:scoring_pad/managers/current_game_manager.dart';
import 'package:scoring_pad/presentation/widgets/rules_widget.dart';

import '../../models/game_catalog.dart';

class RulesScreen extends ConsumerWidget {
  static const String path = 'rules';

  const RulesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppLocalizations tr = AppLocalizations.of(context);
    final currentGameType = ref.read(currentGameManager).gameType;
    final GameEngine? currentGameEngine = currentGameType != null ? GameCatalog().getGameEngine(currentGameType) : null;
    return Scaffold(
      appBar: AppBar(
        title: Text(tr.rules),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: RulesWidget(gameEngine: currentGameEngine),
    );
  }
}
