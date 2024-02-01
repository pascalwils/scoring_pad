import 'package:flutter/material.dart';

import 'default_button.dart';

class ButtonsMenuItem {
  final String title;
  final StyleEnum style;
  final void Function(BuildContext) callback;

  ButtonsMenuItem({required this.title, required this.style, required this.callback});
}

class ButtonsMenu extends StatelessWidget {
  static const double defaultButtonWidth = 250;
  static const double defaultButtonSpacing = 20;
  final List<ButtonsMenuItem> _entries;
  final double buttonSpacing;
  final double buttonWidth;

  const ButtonsMenu(List<ButtonsMenuItem> entries,
      {this.buttonWidth = defaultButtonWidth, this.buttonSpacing = defaultButtonSpacing})
      : _entries = entries;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        direction: Axis.vertical,
        spacing: buttonSpacing,
        children: [
          for (final entry in _entries)
            SizedBox(
              width: buttonWidth,
              child: DefaultButton(
                onPressed: () => entry.callback(context),
                label: entry.title,
                styleEnum: entry.style,
              ),
            )
        ],
      ),
    );
  }
}
