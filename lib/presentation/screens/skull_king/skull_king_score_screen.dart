import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import 'skull_king_score_screen_state_provider.dart';
import 'skull_king_score_widget.dart';

class SkullKingScoreScreen extends ConsumerWidget {
  static const String path = "skull-king-score";

  const SkullKingScoreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppLocalizations tr = AppLocalizations.of(context);
    final state = ref.watch(skullKingScoreScreenProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(tr.scoreboard),
        leading: TextButton(
          onPressed: () => context.pop(),
          child: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
        actions: [],
      ),
      body: SkullKingScoreWidget(state: state),
    );
  }
}
