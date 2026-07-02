// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Flutter Freedom';

  @override
  String get languageToggle => 'فارسی';

  @override
  String get currentOS => 'Current OS';

  @override
  String get aboutDescription =>
      'Flutter Freedom is created by Masoud Ghasemi to overcome the existing limitations for Flutter developers in Iran.\nThis app is released as OpenSource under GPL v3.0 license. Any copying and usage of it is only allowed on the condition of sharing changes for free.';

  @override
  String get telegramChannel => 'Telegram Channel';

  @override
  String get githubRepo => 'GitHub Repo';

  @override
  String get sectionDownloadLinks => 'Download Links';

  @override
  String get sectionMirrorSetup => 'Mirror Setup';

  @override
  String get sectionHelpfulLinks => 'Helpful Links';

  @override
  String get downloadFlutterSdk => 'Download Flutter SDK';

  @override
  String get downloadAndroidSdk => 'Download Android SDK';

  @override
  String get stepEnvVars => 'Step 1 — Environment Variables';

  @override
  String get stepGradleInit => 'Step 2 — Gradle Init Script (Maven Mirror)';

  @override
  String get stepGradleWrapper => 'Step 3 — Gradle Wrapper Properties';

  @override
  String get stepEnvVarsDesc =>
      'Sets PUB_HOSTED_URL and FLUTTER_STORAGE_BASE_URL system environment variables.\n(Required for all platforms, including Android)\nNote: You may need to restart your IDE or terminal after applying this step for the changes to take effect.\nOnly do once on your machine, not per project.';

  @override
  String get stepGradleInitDesc =>
      'Creates mirror.init.gradle.kts inside .gradle/init.d to redirect Maven repositories.\n(Only needed for Android development)\nRequires Gradle 7.0+\nWorks for all Gradle-based projects, not just Flutter.\nCan be used alongside Step 3 or on its own.\nOnly do once on your machine, not per project.';

  @override
  String get stepGradleWrapperDesc =>
      'Updates gradle-wrapper.properties in your Flutter project to use a mirror for Gradle downloads.\nNeeds to be done per Flutter project.\nOnly affects Gradle distribution downloads, not dependencies.\nOn linux MUST have zenity installed  (sudo apt install zenity) or kdialog on KDE (sudo apt install kdialog)';

  @override
  String get selectMirror => 'Select Mirror';

  @override
  String get applyMirror => 'Apply';

  @override
  String get revertMirror => 'Revert';

  @override
  String get autoSetup => 'Auto Setup (Steps 1 & 2)';

  @override
  String get autoSetupDesc =>
      'Automatically applies Myket mirror for environment variables and Gradle init script.';

  @override
  String get selectProjectFolder => 'Select Flutter Project Folder';

  @override
  String get mirrorSetupDesc =>
      'For developing Android apps with Flutter, you need to do steps 2 and 3, otherwise step 1 is sufficient for Desktop and Web projects.';

  @override
  String folderSelected(String path) {
    return 'Folder: $path';
  }

  @override
  String get noFolderSelected => 'No folder selected';

  @override
  String get statusApplied => 'Applied';

  @override
  String get statusNotApplied => 'Not Applied';

  @override
  String get successEnvSet => 'Environment variables set successfully.';

  @override
  String get successEnvReverted => 'Environment variables reverted.';

  @override
  String get successFileCreated => 'Gradle init file created.';

  @override
  String get successFileChanged => 'Gradle init file updated.';

  @override
  String get successFileRemoved => 'Gradle init file removed.';

  @override
  String get successWrapperUpdated => 'gradle-wrapper.properties updated.';

  @override
  String get successWrapperReverted =>
      'gradle-wrapper.properties reverted to official source.';

  @override
  String get errorUserFolderNotFound => 'User home folder not found.';

  @override
  String get errorFileNotExist => 'File does not exist.';

  @override
  String get errorFileAlreadyCorrect => 'File is already set to this mirror.';

  @override
  String get errorWrapperNotFound =>
      'gradle-wrapper.properties not found in the selected folder.';

  @override
  String get errorWrapperReadFailed =>
      'Failed to read gradle-wrapper.properties.';

  @override
  String errorGeneric(String message) {
    return 'An error occurred: $message';
  }

  @override
  String get errorNoFolderSelected =>
      'Please select a Flutter project folder first.';

  @override
  String get errorAdminRequired =>
      'This operation may require administrator privileges on Windows.';

  @override
  String errorAutoSetupFailed(String message) {
    return 'Auto setup failed: $message';
  }

  @override
  String get autoSetupSuccess => 'Auto setup completed successfully.';

  @override
  String get mirrorMyket => 'Myket';

  @override
  String get mirrorRunflare => 'Runflare';

  @override
  String get mirrorChinese => 'Chinese';

  @override
  String get mirrorTaraz => 'Taraz';

  @override
  String get mirrorDevNeeds => 'DevNeeds';

  @override
  String get helpfulLinkPubMyket => 'pub.dev Mirror (Myket)';

  @override
  String get helpfulLinkPubTaraz => 'pub.dev Mirror (Taraz)';

  @override
  String get helpfulLinkMavenMyket => 'Myket Mirrors Docs';

  @override
  String get helpfulLinkRunflareDocs => 'Runflare Mirrors Docs';

  @override
  String get helpfulLinkFlutterGems => 'Flutter Gems';

  @override
  String get helpfulLinkUndraw => 'unDraw Illustrations';

  @override
  String get helpfulLinkSvgRepo => 'SVG Repo';

  @override
  String get helpfulLinkAwesomeFlutter => 'Awesome Flutter (GitHub)';

  @override
  String get helpfulLinkFlutterAwesome => 'Flutter Awesome';

  @override
  String currentValue(String value) {
    return 'Current: $value';
  }

  @override
  String get notSet => 'Not set';

  @override
  String get confirmRevert => 'Are you sure you want to revert this step?';

  @override
  String get yes => 'Yes';

  @override
  String get cancel => 'Cancel';
}
