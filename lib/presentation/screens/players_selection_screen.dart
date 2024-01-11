import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:scoring_pad/domain/repositories/player_repository.dart';

import '../../di.dart';
import '../../domain/entities/player.dart';
import '../widgets/player_edition_dialog.dart';
import '../widgets/player_palette.dart';
import '../palettes.dart';

class PlayersSelectionScreen extends StatefulWidget {
  static const String path = '/select-players';
  static const int defaultMinPlayers = 2;
  static const int defaultMaxPlayers = 10;

  final int minPlayers;
  final int maxPlayers;

  const PlayersSelectionScreen({
    super.key,
    this.minPlayers = defaultMinPlayers,
    this.maxPlayers = defaultMaxPlayers,
  });

  @override
  State<PlayersSelectionScreen> createState() => _PlayersSelectionScreenState();
}

class SelectedPlayer {
  final String name;
  final int colorIndex;

  SelectedPlayer({required this.name, required this.colorIndex});

  factory SelectedPlayer.fromPlayer(Player player, int colorIndex) {
    return SelectedPlayer(name: player.name, colorIndex: colorIndex);
  }
}

class _PlayersSelectionScreenState extends State<PlayersSelectionScreen> {
  final List<SelectedPlayer> _selectedPlayers = List<SelectedPlayer>.empty(growable: true);
  final List<Player> _availablePlayers = getIt.get<PlayerRepository>().getAllPlayers().toList(growable: true);
  final List<int> _availableColorIndices = List<int>.generate(lightColors.length, (index) => index, growable: true);

  @override
  Widget build(BuildContext context) {
    AppLocalizations tr = AppLocalizations.of(context);
    final List<Color> palette = getColorPalette(Theme.of(context).brightness);
    return Scaffold(
      appBar: AppBar(
        title: Text(tr.selectPlayers),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _selectedPlayers.length >= widget.minPlayers && _selectedPlayers.length <= widget.maxPlayers
                ? () {
                    context.pop(_selectedPlayers);
                  }
                : null,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: _selectedPlayers.isNotEmpty
                ? ReorderableListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    children: [
                      for (int index = 0; index < _selectedPlayers.length; index += 1)
                        ListTile(
                          key: Key('$index'),
                          leading: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: palette[_selectedPlayers[index].colorIndex],
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 1,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          //tileColor: index.isOdd ? oddItemColor : evenItemColor,
                          title: Text(_selectedPlayers[index].name),
                          trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                setState(() {
                                  final SelectedPlayer player = _selectedPlayers.removeAt(index);
                                  _availablePlayers.add(Player(name: player.name));
                                  _availableColorIndices.add(player.colorIndex);
                                });
                              }),
                        ),
                    ],
                    onReorder: (int oldIndex, int newIndex) {
                      setState(() {
                        if (oldIndex < newIndex) {
                          newIndex -= 1;
                        }
                        final SelectedPlayer item = _selectedPlayers.removeAt(oldIndex);
                        _selectedPlayers.insert(newIndex, item);
                      });
                    },
                  )
                : Center(child: Text(tr.emptyPlayerList)),
          ),
          _selectedPlayers.length < widget.maxPlayers
              ? PlayerPalette.fromItems(
                  _availablePlayers,
                  (String key) async {
                    if (key == PlayerPalette.addButtonKey) {
                      var player = await _displayTextInputDialog(context);
                      if (player != null) {
                        getIt.get<PlayerRepository>().addPlayer(player);
                        setState(() {
                          _selectedPlayers.add(SelectedPlayer.fromPlayer(player, _getAvailableColorIndex()));
                        });
                      }
                    } else {
                      setState(() {
                        int index = _availablePlayers.indexWhere((e) => e.name == key);
                        final Player player = _availablePlayers.removeAt(index);
                        _selectedPlayers.add(SelectedPlayer.fromPlayer(player, _getAvailableColorIndex()));
                      });
                    }
                  },
                )
              : Container(),
        ],
      ),
    );
  }

  Future<Player?> _displayTextInputDialog(BuildContext context) async {
    return showDialog<Player?>(
      context: context,
      builder: (context) => createPlayerEditionDialog(context, null),
    );
  }

  int _getAvailableColorIndex() {
    return _availableColorIndices.removeAt(0);
  }
}
