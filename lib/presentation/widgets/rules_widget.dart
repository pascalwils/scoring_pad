import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:scoring_pad/game_engines/game_engine.dart';

class RulesWidget extends StatelessWidget {
  static const rulesPathPrefix = "assets/rules";
  static const rulesFileExtension = "md";

  final GameEngine gameEngine;

  const RulesWidget({super.key, required this.gameEngine});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: DefaultAssetBundle.of(context).loadString(_getFilename(context)),
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

  String _getFilename(BuildContext context) {
    final Locale currentLocale = Localizations.localeOf(context);
    return "$rulesPathPrefix/${gameEngine.getRulesFilename(context)}-$currentLocale.$rulesFileExtension";
  }
}
