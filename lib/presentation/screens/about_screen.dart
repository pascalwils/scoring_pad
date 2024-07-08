import 'package:about/about.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../pubspec.dart';

class AboutScreen extends StatelessWidget {
  static const String path = 'about';

  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations tr = AppLocalizations.of(context);
    Locale currentLocale = Localizations.localeOf(context);
    return AboutPage(
      scaffoldBuilder: (_, __, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(tr.appTitle),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                context.pop();
              },
            ),
          ),
          body: child,
        );
      },
      values: {
        'version': Pubspec.version,
        'buildNumber': Pubspec.versionBuild.toString(),
        'year': DateTime.now().year.toString(),
        'author': Pubspec.authorsName.join(', '),
      },
      title: Text(tr.about),
      applicationVersion: 'Version {{ version }}, build #{{ buildNumber }}',
      applicationDescription: Column(
        children: [
          Text(
            tr.appDescriptionLine1,
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 12),
          Text(
            tr.appDescriptionLine2,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
      applicationIcon: SizedBox(
        width: 200,
        height: 200,
        child: Image.asset(
          "assets/icons/app_icon.webp",
          fit: BoxFit.scaleDown,
        ),
      ),
      applicationLegalese: 'Copyright © {{ author }}, {{ year }}',
      children: <Widget>[
        MarkdownPageListTile(
          filename: _getReadMeFilename(currentLocale),
          title: Text(tr.aboutViewReadme),
          icon: const Icon(Icons.all_inclusive),
        ),
        LicensesPageListTile(
          title: Text(tr.aboutOpenSourceLicenses),
          icon: const Icon(Icons.favorite),
        ),
      ],
    );
  }

  String _getReadMeFilename(Locale locale) {
    if (locale.languageCode == "en") {
      return "README.md";
    }
    return "README.$locale.md";
  }
}
