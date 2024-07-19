import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../models/player.dart';

const double rowHeight = 48.0;

class PlayerPalette extends StatelessWidget {
  static const String addButtonKey = "__";
  final List<Player> items;
  final void Function(String key) listener;

  const PlayerPalette._internal({required this.items, required this.listener});

  factory PlayerPalette.fromItems(List<Player> items, void Function(String key) listener) {
    List<Player> result = List.from(items);
    result.insert(0, const Player(name: addButtonKey));
    return PlayerPalette._internal(items: result, listener: listener);
  }

  @override
  Widget build(BuildContext context) {
    return LimitedBox(
      maxHeight: 3 * rowHeight,
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: SingleChildScrollView(
          child: CustomMultiChildLayout(
            delegate: _SimpleGridLayoutDelegate(
              items: items.map((e) => e.name).toList(),
              textDirection: Directionality.of(context),
            ),
            children: [
              // Create all of the colored boxes in the colors map.
              for (final entry in items)
                // The "id" can be any Object, not just a String.
                LayoutId(
                  id: entry.name,
                  child: _buildWidget(context, entry),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWidget(BuildContext context, Player item) {
    final scheme = Theme.of(context).colorScheme;
    final background = item.name == "__" ? scheme.primary : scheme.secondaryContainer;
    final foreground = item.name == "__" ? scheme.onPrimary : scheme.onSecondaryContainer;
    return Material(
      color: background,
      child: InkWell(
        onTap: () {
          listener(item.name);
        },
        child: Container(
          width: double.infinity,
          height: rowHeight,
          alignment: Alignment.center,
          child: (item.name == addButtonKey) ? _buildIconAndText(context, foreground) : _buildText(item.name, foreground),
        ),
      ),
    );
  }

  Widget _buildIconAndText(BuildContext context, Color color) {
    AppLocalizations tr = AppLocalizations.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Icon(Icons.add, color: color),
        _buildText(tr.newPlayer, color),
      ],
    );
  }

  Widget _buildText(String text, Color color) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _SimpleGridLayoutDelegate extends MultiChildLayoutDelegate {
  static const double minimumColumnWidth = 115.0;

  _SimpleGridLayoutDelegate({
    required this.items,
    required this.textDirection,
  });

  final List<String> items;
  final TextDirection textDirection;

  @override
  void performLayout(Size size) {
    final int nbColumns = (size.width / minimumColumnWidth).ceil();
    final double columnWidth = size.width / nbColumns;
    Offset childPosition = Offset.zero;
    switch (textDirection) {
      case TextDirection.rtl:
        childPosition += Offset(size.width, 0);
      case TextDirection.ltr:
        break;
    }
    int currentIndex = 1;
    for (final String itemId in items) {
      // layoutChild must be called exactly once for each child.
      final Size currentSize = layoutChild(
        itemId,
        BoxConstraints(maxHeight: size.height, maxWidth: columnWidth),
      );

      switch (textDirection) {
        case TextDirection.rtl:
          positionChild(itemId, childPosition - Offset(currentSize.width, 0));
          if (currentIndex % nbColumns == 0) {
            childPosition = Offset(size.width, childPosition.dy + rowHeight);
          } else {
            childPosition += Offset(-currentSize.width, 0);
          }
        case TextDirection.ltr:
          positionChild(itemId, childPosition);
          if (currentIndex % nbColumns == 0) {
            childPosition = Offset(0, childPosition.dy + rowHeight);
          } else {
            childPosition += Offset(currentSize.width, 0);
          }
      }
      currentIndex += 1;
    }
  }

  @override
  bool shouldRelayout(_SimpleGridLayoutDelegate oldDelegate) {
    return oldDelegate.textDirection != textDirection;
  }

  @override
  Size getSize(BoxConstraints constraints) {
    final int nbColumns = (constraints.maxWidth / minimumColumnWidth).ceil();
    final int nbRows = (items.length / nbColumns).ceil();
    return Size(constraints.maxWidth, nbRows * rowHeight);
  }
}
