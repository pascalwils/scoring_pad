import 'package:flutter/material.dart';
import 'package:scoring_pad/presentation/app_color_schemes.dart';
import 'package:scoring_pad/presentation/screens/standard_game/standard_game_player_round_state.dart';

import '../../graphic_tools.dart';

class StandardGamePlayerTile extends StatelessWidget {
  static const double buttonSize = 48.0;

  final StandardGamePlayerRoundState state;
  final void Function(int) callback;
  final int? remainder;

  const StandardGamePlayerTile({super.key, required this.state, required this.callback, this.remainder});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme.playerSchemes[state.colorIndex];
    final normalTextStyle = TextStyle(color: computeColorForText(scheme.text), fontSize: 16);
    final boldTextStyle = normalTextStyle.copyWith(fontWeight: FontWeight.bold);
    final scoreTextStyle = normalTextStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 32);
    final showRemainder = remainder != null;

    return Padding(
      padding: const EdgeInsets.all(4),
      child: Ink(
        decoration: BoxDecoration(
          color: scheme.background,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(onPressed: () => callback(state.roundScore - 1), child: const Text("-1")),
                    TextButton(onPressed: () => callback(state.roundScore - 5), child: const Text("-5")),
                    TextButton(onPressed: () => callback(state.roundScore - 10), child: const Text("-10")),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(state.name, style: boldTextStyle),
                            Text("${state.totalScore}", style: boldTextStyle),
                          ],
                        ),
                        Text("${state.roundScore}", style: scoreTextStyle),
                        Visibility(
                          visible: showRemainder,
                          child: TextButton(
                            onPressed: () => callback(state.roundScore + remainder!),
                            child: Text(_getRemainderString()),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(onPressed: () => callback(state.roundScore + 1), child: const Text("+1")),
                    TextButton(onPressed: () => callback(state.roundScore + 5), child: const Text("+5")),
                    TextButton(onPressed: () => callback(state.roundScore + 10), child: const Text("+10")),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getRemainderString() {
    if (remainder == null) {
      return "";
    }
    if (remainder! < 0) {
      return "$remainder";
    }
    return "+$remainder";
  }
}
