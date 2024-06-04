import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:scoring_pad/presentation/screens/skull_king/skull_king_score_screen_state.dart';

import '../../graphic_tools.dart';
import '../../palettes.dart';

class SkullKingScoreWidget extends StatelessWidget {
  final SkullKingScoreScreenState state;

  const SkullKingScoreWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    AppLocalizations tr = AppLocalizations.of(context);
    final List<Color> palette = getColorPalette(Theme.of(context).brightness);
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: state.scores.length,
            itemBuilder: (context, index) {
              final score = state.scores[index];
              final scheme = getColorScheme(Theme.of(context).brightness, score.player.colorIndex);
              final textStyle = TextStyle(color: computeColorForText(scheme.text), fontSize: 14);
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                child: Row(
                  children: [
                    Icon(Icons.circle, color: palette[score.player.colorIndex]),
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
            },
          ),
        )
      ],
    );
  }
}
