class AppLink {
  final String labelKey; // i18n key
  final String url;
  const AppLink({required this.labelKey, required this.url});
}

const String flutterSdkUrl =
    'https://ghasemimasoud.ir/flutter-freedom/flutter-sdk.html';
const String androidSdkUrl =
    'https://ghasemimasoud.ir/flutter-freedom/android-sdk.html';

const List<AppLink> helpfulLinks = [
  AppLink(labelKey: 'helpfulLinkPubMyket', url: 'https://pub.myket.ir'),
  AppLink(labelKey: 'helpfulLinkPubTaraz', url: 'https://pub.tarazerp.ir'),
  AppLink(labelKey: 'helpfulLinkMavenMyket', url: 'https://maven.myket.ir'),
  AppLink(
    labelKey: 'helpfulLinkRunflareDocs',
    url: 'https://runflare.com/mirrors',
  ),
  AppLink(labelKey: 'helpfulLinkFlutterGems', url: 'https://fluttergems.dev'),
  AppLink(
    labelKey: 'helpfulLinkUndraw',
    url: 'https://undraw.co/illustrations',
  ),
  AppLink(labelKey: 'helpfulLinkSvgRepo', url: 'https://www.svgrepo.com'),
  AppLink(
    labelKey: 'helpfulLinkAwesomeFlutter',
    url: 'https://github.com/solido/awesome-flutter',
  ),
  AppLink(
    labelKey: 'helpfulLinkFlutterAwesome',
    url: 'https://flutterawesome.com',
  ),
];
