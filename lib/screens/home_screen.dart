import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_freedom/generated/app_localizations.dart';
import '../providers/app_provider.dart';
import 'sections/download_links_section.dart';
import 'sections/mirror_setup_section.dart';
import 'sections/helpful_links_section.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final provider = context.watch<AppProvider>();
    final isRtl = provider.locale.languageCode == 'fa';
    final platform = Platform.operatingSystem;

    return Directionality(
      textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF54C5F8),
          elevation: 0,
          title: Text(
            l10n.appTitle,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text("${l10n.currentOS}: ${platform.toUpperCase()}"),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: TextButton(
                onPressed: () => provider.toggleLocale(),
                child: Row(
                  children: [
                    Text(
                      l10n.languageToggle,
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(width: 5),
                    const FaIcon(
                      FontAwesomeIcons.language,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: IconButton(
                onPressed: () => showAbout(context),
                icon: FaIcon(FontAwesomeIcons.circleInfo, color: Colors.white),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 860),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _SectionCard(
                    title: l10n.sectionDownloadLinks,
                    icon: FontAwesomeIcons.download,
                    child: const DownloadLinksSection(),
                  ),
                  const SizedBox(height: 24),
                  _SectionCard(
                    title: l10n.sectionMirrorSetup,
                    icon: FontAwesomeIcons.gear,
                    child: const MirrorSetupSection(),
                  ),
                  const SizedBox(height: 24),
                  _SectionCard(
                    title: l10n.sectionHelpfulLinks,
                    icon: FontAwesomeIcons.link,
                    child: const HelpfulLinksSection(),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final FaIconData icon;
  final Widget child;

  const _SectionCard({
    required this.title,
    required this.icon,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                FaIcon(icon, color: const Color(0xFF54C5F8), size: 22),
                const SizedBox(width: 10),
                Text(title, style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
            const Divider(height: 28),
            child,
          ],
        ),
      ),
    );
  }
}

void showAbout(BuildContext context) {
  showAboutDialog(
    context: context,
    applicationName: AppLocalizations.of(context)!.appTitle,
    applicationVersion: AppVars.appVersion,
    children: [
      Text(
        AppLocalizations.of(context)!.aboutDescription,
        // "این برنامه توسط مسعود قاسمی برای تمامی برنامه نویسان فلاتر سرزمین ایران ساخته شده است. هزینه استفاده از آن دعای خیر شما دوست عزیز میباشد.",
      ),
      SizedBox(height: 10),
      Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Tooltip(
            message: AppLocalizations.of(context)!.githubRepo,
            child: IconButton(
              onPressed: () {
                launchUrl(
                  Uri.parse(
                    "https://github.com/MadhouseSigma/flutter-freedom-iran",
                  ),
                );
              },
              icon: FaIcon(
                FontAwesomeIcons.github,
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
          Tooltip(
            message: AppLocalizations.of(context)!.telegramChannel,
            child: IconButton(
              onPressed: () {
                launchUrl(Uri.parse("https://t.me/flutterfreedom"));
              },
              icon: FaIcon(
                FontAwesomeIcons.telegram,
                size: 30,
                color: Colors.blue.shade300,
              ),
            ),
          ),
        ],
      ),
    ],
  );
}
