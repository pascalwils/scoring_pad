import 'package:flutter/material.dart';
import 'package:scoring_pad/presentation/widgets/fast_color_picker.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../domain/entities/player.dart';
import 'default_button.dart';

Widget createPlayerEditionDialog(BuildContext context, Player? player) {
  AppLocalizations tr = AppLocalizations.of(context);

  return AlertDialog(
    content: StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return const AlertItem();
      },
    ),
    actions: [
      DefaultButton.text(
        label: tr.cancel,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      DefaultButton.text(
        label: player != null ? tr.update : tr.add,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    ],
  );
}

class AlertItem extends StatefulWidget {
  const AlertItem({super.key});

  @override
  State<AlertItem> createState() => _AlertItemState();
}

class _AlertItemState extends State<AlertItem> {
  String? name = null;
  Color selectedColor = FastColorPicker.getDefaultColor();

  @override
  Widget build(BuildContext context) {
    AppLocalizations tr = AppLocalizations.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          onChanged: (value) {},
          decoration: InputDecoration(
            hintText: tr.playerName,
            prefixIcon: const Icon(Icons.circle),
            prefixIconColor: selectedColor,
          ),
        ),
        const SizedBox(height: 6),
        FastColorPicker(
          selectedColor: selectedColor,
          onColorSelected: (Color color) {
            setState(() {
              selectedColor = color;
            });
          },
        ),
      ],
    );
  }
}
