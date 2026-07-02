import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_freedom/generated/app_localizations.dart';
import '../../constants/links.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HelpfulLinksSection extends StatelessWidget {
  const HelpfulLinksSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: helpfulLinks.map((link) {
        return _LinkChip(
          label: _resolveLabel(link.labelKey, l10n),
          url: link.url,
        );
      }).toList(),
    );
  }

  String _resolveLabel(String key, AppLocalizations l10n) {
    switch (key) {
      case 'helpfulLinkPubMyket':
        return l10n.helpfulLinkPubMyket;
      case 'helpfulLinkPubTaraz':
        return l10n.helpfulLinkPubTaraz;
      case 'helpfulLinkMavenMyket':
        return l10n.helpfulLinkMavenMyket;
      case 'helpfulLinkRunflareDocs':
        return l10n.helpfulLinkRunflareDocs;
      case 'helpfulLinkFlutterGems':
        return l10n.helpfulLinkFlutterGems;
      case 'helpfulLinkUndraw':
        return l10n.helpfulLinkUndraw;
      case 'helpfulLinkSvgRepo':
        return l10n.helpfulLinkSvgRepo;
      case 'helpfulLinkAwesomeFlutter':
        return l10n.helpfulLinkAwesomeFlutter;
      case 'helpfulLinkFlutterAwesome':
        return l10n.helpfulLinkFlutterAwesome;
      default:
        return key;
    }
  }
}

class _LinkChip extends StatelessWidget {
  final String label;
  final String url;

  const _LinkChip({required this.label, required this.url});

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      avatar: const FaIcon(
        FontAwesomeIcons.arrowUpFromBracket,
        size: 14,
        color: Color(0xFF54C5F8),
      ),
      label: Text(label),
      labelStyle: const TextStyle(fontSize: 13, color: Color(0xFFB0B0C0)),
      backgroundColor: const Color(0xFF1E1E30),
      side: const BorderSide(color: Color(0xFF2A2A40)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      onPressed: () => launchUrl(Uri.parse(url)),
    );
  }
}
