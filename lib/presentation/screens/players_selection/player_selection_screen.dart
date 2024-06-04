import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../managers/current_game_manager.dart';
import '../../../managers/players_manager.dart';
import '../../../models/player.dart';
import '../../widgets/player_edition/player_edition_dialog.dart';
import '../../widgets/player_palette.dart';
import '../../palettes.dart';
import 'player_selection_state.dart';
import 'player_selection_state_provider.dart';

class PlayerSelectionScreen extends ConsumerWidget {
  static const String path = 'select-players';

  final int minPlayers;
  final int maxPlayers;

  const PlayerSelectionScreen({super.key, required this.minPlayers, required this.maxPlayers});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppLocalizations tr = AppLocalizations.of(context);
    final List<Color> palette = getColorPalette(Theme.of(context).brightness);
    final state = ref.watch(playerSelectionProvider);
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
            onPressed: state.isValid(minPlayers: minPlayers, maxPlayers: maxPlayers)
                ? () {
                    final engine = ref.read(currentEngineProvider);
                    engine?.startGame(context, ref, state.selectedPlayers);
                  }
                : null,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: state.selectedPlayers.isNotEmpty
                ? ReorderableListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    children: [
                      for (int index = 0; index < state.selectedPlayers.length; index += 1)
                        ListTile(
                          key: Key('$index'),
                          leading: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: palette[state.selectedPlayers[index].colorIndex],
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 1,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          //tileColor: index.isOdd ? oddItemColor : evenItemColor,
                          title: Text(state.selectedPlayers[index].name),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              ref.read(playerSelectionProvider.notifier).deletePlayer(index);
                            },
                          ),
                        ),
                    ],
                    onReorder: (int oldIndex, int newIndex) {
                      ref.read(playerSelectionProvider.notifier).reorderPlayers(oldIndex, newIndex);
                    },
                  )
                : Center(child: Text(tr.emptyPlayerList)),
          ),
          state.selectedPlayers.length < maxPlayers
              ? PlayerPalette.fromItems(
                  _getPaletteItems(ref.watch(playersManager), state),
                  (String key) async {
                    if (key == PlayerPalette.addButtonKey) {
                      var player = await _displayTextInputDialog(context);
                      if (player != null) {
                        ref.read(playersManager.notifier).addPlayer(player);
                        ref.read(playerSelectionProvider.notifier).addPlayer(player.name);
                      }
                    } else {
                      ref.read(playerSelectionProvider.notifier).addPlayer(key);
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

  List<Player> _getPaletteItems(List<Player> players, PlayerSelectionState state) {
    return players.where((e) => !state.contains(e)).toList();
  }
}
