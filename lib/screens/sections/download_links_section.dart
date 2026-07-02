import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_freedom/generated/app_localizations.dart';
import '../../constants/links.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DownloadLinksSection extends StatelessWidget {
  const DownloadLinksSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Wrap(
      spacing: 16,
      runSpacing: 12,
      children: [
        _DownloadButton(
          label: l10n.downloadFlutterSdk,
          icon: FontAwesomeIcons.flutter,
          url: flutterSdkUrl,
          color: const Color(0xFF54C5F8),
        ),
        _DownloadButton(
          label: l10n.downloadAndroidSdk,
          icon: FontAwesomeIcons.android,
          url: androidSdkUrl,
          color: const Color(0xFF78C257),
        ),
      ],
    );
  }
}

class _DownloadButton extends StatelessWidget {
  final String label;
  final FaIconData icon;
  final String url;
  final Color color;

  const _DownloadButton({
    required this.label,
    required this.icon,
    required this.url,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: color.withValues(alpha: 0.15),
        foregroundColor: color,
        side: BorderSide(color: color.withValues(alpha: 0.5)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 0,
      ),
      icon: FaIcon(icon, size: 20),
      label: Text(
        label,
      ),
      onPressed: () => launchUrl(Uri.parse(url)),
    );
  }
}
