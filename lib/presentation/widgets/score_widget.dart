import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:scoring_pad/presentation/widgets/score_graph_widget.dart';

import '../graphic_tools.dart';
import '../app_color_schemes.dart';
import 'score_widget_state.dart';

class ScoreWidget extends StatelessWidget {
  final ScoreWidgetState state;

  const ScoreWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    AppLocalizations tr = AppLocalizations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final playerSchemes = colorScheme.playerSchemes;
    return Column(
      children: [
        Column(
          children: _getScoreRows(context, playerSchemes),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Card(
              child: ScoreGraphWidget(
                scores: state.scores,
                translation: tr,
                graphScheme: colorScheme.graphScheme,
                playerSchemes: playerSchemes,
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _getScoreRows(BuildContext context, List<PlayerColorScheme> schemes) {
    return state.scores.map((it) => _getScoreRow(context, it, schemes[it.player.colorIndex])).toList();
  }

  Widget _getScoreRow(BuildContext context, PlayerScore score, PlayerColorScheme scheme) {
    final textStyle = TextStyle(color: computeColorForText(scheme.text), fontSize: 14);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      child: Row(
        children: [
          Icon(Icons.circle, color: scheme.base),
          const SizedBox(width: 4),
          Text(
            score.player.name,
            style: textStyle,
          ),
          const Spacer(),
          Text(
            score.scores.last.toString(),
            style: textStyle,
          ),
        ],
      ),
    );
  }
}
