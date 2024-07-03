import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:scoring_pad/translation_support.dart';

import '../../models/game_type.dart';

class RulesWidget extends StatelessWidget {
  final GameType gameType;

  const RulesWidget({super.key, required this.gameType});

  @override
  Widget build(BuildContext context) {
    final Locale currentLocale = Localizations.localeOf(context);
    return FutureBuilder<String>(
      future: DefaultAssetBundle.of(context).loadString(gameType.getRulesFilePath(currentLocale)),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Markdown(
            data: snapshot.requireData,
            styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
              blockquoteDecoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(2.0),
              ),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
