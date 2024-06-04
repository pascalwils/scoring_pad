import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/player.dart';
import '../default_button.dart';
import 'player_edition_dialog_provider.dart';

Widget createPlayerEditionDialog(BuildContext context, Player? player) {
  return AlertDialog(
    content: StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return _PlayerSelectionContent(player: player);
      },
    ),
  );
}

class _PlayerSelectionContent extends StatelessWidget {
  final Player? player;

  const _PlayerSelectionContent({this.player});

  @override
  Widget build(BuildContext context) {
    AppLocalizations tr = AppLocalizations.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Consumer(
          builder: (context, ref, _) {
            final field = ref.watch(playerEditionDialogNotifierProvider).name;
            return TextFormField(
              initialValue: field.isValid ? field.value : player?.name ?? "",
              onChanged: (value) => ref.read(playerEditionDialogNotifierProvider.notifier).setName(value),
              decoration: InputDecoration(
                hintText: tr.playerName,
              ),
            );
          },
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            DefaultButton.text(
              label: tr.cancel,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Consumer(
              builder: (context, ref, _) {
                final state = ref.watch(playerEditionDialogNotifierProvider);
                return DefaultButton.text(
                  label: player != null ? tr.update : tr.add,
                  onPressed: state.isValid()
                      ? () {
                          Navigator.pop(context, Player(name: state.name.value));
                        }
                      : null,
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
