import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/player.dart';
import '../widgets/player_edition_dialog.dart';
import '../widgets/player_palette.dart';

class PlayersSelectionScreen extends StatefulWidget {
  static const String path = '/select-players';

  const PlayersSelectionScreen({super.key});

  @override
  State<PlayersSelectionScreen> createState() => _PlayersSelectionScreenState();
}

class _PlayersSelectionScreenState extends State<PlayersSelectionScreen> {
  static const String path = '/select-players';

  final List<int> _items = List<int>.generate(5, (int index) => index);

  final List<int> _availableItems = List<int>.generate(0, (int index) => index);

  _PlayersSelectionScreenState();

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Select players"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ReorderableListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              children: <Widget>[
                for (int index = 0; index < _items.length; index += 1)
                  ListTile(
                    key: Key('$index'),
                    tileColor: _items[index].isOdd ? oddItemColor : evenItemColor,
                    title: Text('Item ${_items[index]}'),
                  ),
              ],
              onReorder: (int oldIndex, int newIndex) {
                setState(() {
                  if (oldIndex < newIndex) {
                    newIndex -= 1;
                  }
                  final int item = _items.removeAt(oldIndex);
                  _items.insert(newIndex, item);
                });
              },
            ),
          ),
          PlayerPalette.fromItems(_buildPaletteItems(), (String key) {
            print(key);
            _displayTextInputDialog(context);
          }),
        ],
      ),
    );
  }

  List<Player> _buildPaletteItems() {
    List<Player> result = List.empty(growable: true);
    result.add(Player(name: "Red", color: Colors.red));
    result.add(Player(name: "Green", color: Colors.green));
    result.add(Player(name: "Blue", color: Colors.blue));
    result.add(Player(name: "Cyan", color: Colors.cyan));
    return result;
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) => createPlayerEditionDialog(context, null),
    );
  }
}
