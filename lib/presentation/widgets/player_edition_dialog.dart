import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../di.dart';
import '../../domain/entities/player.dart';
import '../../domain/repositories/player_repository.dart';
import 'default_button.dart';

Widget createPlayerEditionDialog(BuildContext context, Player? player) {
  return AlertDialog(
    content: StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return _PlayerSelectionContent(player: player);
      },
    ),
  );
}

class _PlayerSelectionContent extends StatefulWidget {
  final Player? player;

  const _PlayerSelectionContent({this.player});

  @override
  State<_PlayerSelectionContent> createState() => _PlayerSelectionContentState();
}

class _PlayerSelectionContentState extends State<_PlayerSelectionContent> {
  String _name = "";

  @override
  void initState() {
    super.initState();

    _name = widget.player?.name ?? "";
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations tr = AppLocalizations.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          initialValue: _name,
          onChanged: (value) {
            setState(() {
              _name = value;
            });
          },
          decoration: InputDecoration(
            hintText: tr.playerName,
          ),
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
            DefaultButton.text(
              label: widget.player != null ? tr.update : tr.add,
              onPressed: _name.isNotEmpty && !getIt.get<PlayerRepository>().containsPlayer(_name)
                  ? () {
                      Navigator.pop(context, Player(name: _name));
                    }
                  : null,
            ),
          ],
        ),
      ],
    );
  }
}
