import 'package:expandable_widgets/expandable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../widgets/IntegerField.dart';

class SkullkingGameScreen extends StatelessWidget {
  const SkullkingGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations tr = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(tr.appTitle),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Ink(
            decoration: BoxDecoration(
              color: Colors.amberAccent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              title: Row(children: [
                Expanded(
                  child: Text("Pascal"),
                ),
                Text("0"),
              ]),
              subtitle: Column(
                children: [
                  _buildLine(context, tr.skBid, 0, 2),
                  _buildLine(context, tr.skTricksWon, 0,2),
                  SizedBox(
                    height: 8,
                  ),
                  Expandable(
                    firstChild: Text(tr.skBonusPoints),
                    secondChild: Padding(
                      padding: EdgeInsets.only(
                        left: 4,
                        right: 4,
                        bottom: 6,
                      ),
                      child: Column(
                        children: [
                          _buildLine(context, tr.skStandard14s, 0, 3),
                          _buildLine(context, tr.skBlack14s, 0, 1),
                          _buildLine(context, tr.skMermaidsCaptured, 0, 2),
                          _buildLine(context, tr.skPiratesCaptured, 0, 5),
                          _buildLine(context, tr.skSkullKingCaptured, 0, 1),
                          _buildLine(context, tr.skLootEarned, 0, 2),
                          _buildLine(context, tr.skRascalBid, 20, 20, step: 10),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLine(BuildContext context, String text, int value, int maxValue, {int step = 1}) {
    return Padding(
      padding: EdgeInsets.only(
        top: 4,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              text,
              textAlign: TextAlign.end,
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          IntegerField(
            initialValue: value,
            maxValue: maxValue,
            step: step,
          ),
        ],
      ),
    );
  }
}
