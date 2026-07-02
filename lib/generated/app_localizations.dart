import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fa.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('fa'),
    Locale('en'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Flutter Freedom'**
  String get appTitle;

  /// No description provided for @languageToggle.
  ///
  /// In en, this message translates to:
  /// **'فارسی'**
  String get languageToggle;

  /// No description provided for @currentOS.
  ///
  /// In en, this message translates to:
  /// **'Current OS'**
  String get currentOS;

  /// No description provided for @aboutDescription.
  ///
  /// In en, this message translates to:
  /// **'Flutter Freedom is created by Masoud Ghasemi to overcome the existing limitations for Flutter developers in Iran.\nThis app is released as OpenSource under GPL v3.0 license. Any copying and usage of it is only allowed on the condition of sharing changes for free.'**
  String get aboutDescription;

  /// No description provided for @telegramChannel.
  ///
  /// In en, this message translates to:
  /// **'Telegram Channel'**
  String get telegramChannel;

  /// No description provided for @githubRepo.
  ///
  /// In en, this message translates to:
  /// **'GitHub Repo'**
  String get githubRepo;

  /// No description provided for @sectionDownloadLinks.
  ///
  /// In en, this message translates to:
  /// **'Download Links'**
  String get sectionDownloadLinks;

  /// No description provided for @sectionMirrorSetup.
  ///
  /// In en, this message translates to:
  /// **'Mirror Setup'**
  String get sectionMirrorSetup;

  /// No description provided for @sectionHelpfulLinks.
  ///
  /// In en, this message translates to:
  /// **'Helpful Links'**
  String get sectionHelpfulLinks;

  /// No description provided for @downloadFlutterSdk.
  ///
  /// In en, this message translates to:
  /// **'Download Flutter SDK'**
  String get downloadFlutterSdk;

  /// No description provided for @downloadAndroidSdk.
  ///
  /// In en, this message translates to:
  /// **'Download Android SDK'**
  String get downloadAndroidSdk;

  /// No description provided for @stepEnvVars.
  ///
  /// In en, this message translates to:
  /// **'Step 1 — Environment Variables'**
  String get stepEnvVars;

  /// No description provided for @stepGradleInit.
  ///
  /// In en, this message translates to:
  /// **'Step 2 — Gradle Init Script (Maven Mirror)'**
  String get stepGradleInit;

  /// No description provided for @stepGradleWrapper.
  ///
  /// In en, this message translates to:
  /// **'Step 3 — Gradle Wrapper Properties'**
  String get stepGradleWrapper;

  /// No description provided for @stepEnvVarsDesc.
  ///
  /// In en, this message translates to:
  /// **'Sets PUB_HOSTED_URL and FLUTTER_STORAGE_BASE_URL system environment variables.\n(Required for all platforms, including Android)\nNote: You may need to restart your IDE or terminal after applying this step for the changes to take effect.\nOnly do once on your machine, not per project.'**
  String get stepEnvVarsDesc;

  /// No description provided for @stepGradleInitDesc.
  ///
  /// In en, this message translates to:
  /// **'Creates mirror.init.gradle.kts inside .gradle/init.d to redirect Maven repositories.\n(Only needed for Android development)\nRequires Gradle 7.0+\nWorks for all Gradle-based projects, not just Flutter.\nCan be used alongside Step 3 or on its own.\nOnly do once on your machine, not per project.'**
  String get stepGradleInitDesc;

  /// No description provided for @stepGradleWrapperDesc.
  ///
  /// In en, this message translates to:
  /// **'Updates gradle-wrapper.properties in your Flutter project to use a mirror for Gradle downloads.\nNeeds to be done per Flutter project.\nOnly affects Gradle distribution downloads, not dependencies.\nOn linux MUST have zenity installed  (sudo apt install zenity) or kdialog on KDE (sudo apt install kdialog)'**
  String get stepGradleWrapperDesc;

  /// No description provided for @selectMirror.
  ///
  /// In en, this message translates to:
  /// **'Select Mirror'**
  String get selectMirror;

  /// No description provided for @applyMirror.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get applyMirror;

  /// No description provided for @revertMirror.
  ///
  /// In en, this message translates to:
  /// **'Revert'**
  String get revertMirror;

  /// No description provided for @autoSetup.
  ///
  /// In en, this message translates to:
  /// **'Auto Setup (Steps 1 & 2)'**
  String get autoSetup;

  /// No description provided for @autoSetupDesc.
  ///
  /// In en, this message translates to:
  /// **'Automatically applies Myket mirror for environment variables and Gradle init script.'**
  String get autoSetupDesc;

  /// No description provided for @selectProjectFolder.
  ///
  /// In en, this message translates to:
  /// **'Select Flutter Project Folder'**
  String get selectProjectFolder;

  /// No description provided for @mirrorSetupDesc.
  ///
  /// In en, this message translates to:
  /// **'For developing Android apps with Flutter, you need to do steps 2 and 3, otherwise step 1 is sufficient for Desktop and Web projects.'**
  String get mirrorSetupDesc;

  /// No description provided for @folderSelected.
  ///
  /// In en, this message translates to:
  /// **'Folder: {path}'**
  String folderSelected(String path);

  /// No description provided for @noFolderSelected.
  ///
  /// In en, this message translates to:
  /// **'No folder selected'**
  String get noFolderSelected;

  /// No description provided for @statusApplied.
  ///
  /// In en, this message translates to:
  /// **'Applied'**
  String get statusApplied;

  /// No description provided for @statusNotApplied.
  ///
  /// In en, this message translates to:
  /// **'Not Applied'**
  String get statusNotApplied;

  /// No description provided for @successEnvSet.
  ///
  /// In en, this message translates to:
  /// **'Environment variables set successfully.'**
  String get successEnvSet;

  /// No description provided for @successEnvReverted.
  ///
  /// In en, this message translates to:
  /// **'Environment variables reverted.'**
  String get successEnvReverted;

  /// No description provided for @successFileCreated.
  ///
  /// In en, this message translates to:
  /// **'Gradle init file created.'**
  String get successFileCreated;

  /// No description provided for @successFileChanged.
  ///
  /// In en, this message translates to:
  /// **'Gradle init file updated.'**
  String get successFileChanged;

  /// No description provided for @successFileRemoved.
  ///
  /// In en, this message translates to:
  /// **'Gradle init file removed.'**
  String get successFileRemoved;

  /// No description provided for @successWrapperUpdated.
  ///
  /// In en, this message translates to:
  /// **'gradle-wrapper.properties updated.'**
  String get successWrapperUpdated;

  /// No description provided for @successWrapperReverted.
  ///
  /// In en, this message translates to:
  /// **'gradle-wrapper.properties reverted to official source.'**
  String get successWrapperReverted;

  /// No description provided for @errorUserFolderNotFound.
  ///
  /// In en, this message translates to:
  /// **'User home folder not found.'**
  String get errorUserFolderNotFound;

  /// No description provided for @errorFileNotExist.
  ///
  /// In en, this message translates to:
  /// **'File does not exist.'**
  String get errorFileNotExist;

  /// No description provided for @errorFileAlreadyCorrect.
  ///
  /// In en, this message translates to:
  /// **'File is already set to this mirror.'**
  String get errorFileAlreadyCorrect;

  /// No description provided for @errorWrapperNotFound.
  ///
  /// In en, this message translates to:
  /// **'gradle-wrapper.properties not found in the selected folder.'**
  String get errorWrapperNotFound;

  /// No description provided for @errorWrapperReadFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to read gradle-wrapper.properties.'**
  String get errorWrapperReadFailed;

  /// No description provided for @errorGeneric.
  ///
  /// In en, this message translates to:
  /// **'An error occurred: {message}'**
  String errorGeneric(String message);

  /// No description provided for @errorNoFolderSelected.
  ///
  /// In en, this message translates to:
  /// **'Please select a Flutter project folder first.'**
  String get errorNoFolderSelected;

  /// No description provided for @errorAdminRequired.
  ///
  /// In en, this message translates to:
  /// **'This operation may require administrator privileges on Windows.'**
  String get errorAdminRequired;

  /// No description provided for @errorAutoSetupFailed.
  ///
  /// In en, this message translates to:
  /// **'Auto setup failed: {message}'**
  String errorAutoSetupFailed(String message);

  /// No description provided for @autoSetupSuccess.
  ///
  /// In en, this message translates to:
  /// **'Auto setup completed successfully.'**
  String get autoSetupSuccess;

  /// No description provided for @mirrorMyket.
  ///
  /// In en, this message translates to:
  /// **'Myket'**
  String get mirrorMyket;

  /// No description provided for @mirrorRunflare.
  ///
  /// In en, this message translates to:
  /// **'Runflare'**
  String get mirrorRunflare;

  /// No description provided for @mirrorChinese.
  ///
  /// In en, this message translates to:
  /// **'Chinese'**
  String get mirrorChinese;

  /// No description provided for @mirrorTaraz.
  ///
  /// In en, this message translates to:
  /// **'Taraz'**
  String get mirrorTaraz;

  /// No description provided for @mirrorDevNeeds.
  ///
  /// In en, this message translates to:
  /// **'DevNeeds'**
  String get mirrorDevNeeds;

  /// No description provided for @helpfulLinkPubMyket.
  ///
  /// In en, this message translates to:
  /// **'pub.dev Mirror (Myket)'**
  String get helpfulLinkPubMyket;

  /// No description provided for @helpfulLinkPubTaraz.
  ///
  /// In en, this message translates to:
  /// **'pub.dev Mirror (Taraz)'**
  String get helpfulLinkPubTaraz;

  /// No description provided for @helpfulLinkMavenMyket.
  ///
  /// In en, this message translates to:
  /// **'Myket Mirrors Docs'**
  String get helpfulLinkMavenMyket;

  /// No description provided for @helpfulLinkRunflareDocs.
  ///
  /// In en, this message translates to:
  /// **'Runflare Mirrors Docs'**
  String get helpfulLinkRunflareDocs;

  /// No description provided for @helpfulLinkFlutterGems.
  ///
  /// In en, this message translates to:
  /// **'Flutter Gems'**
  String get helpfulLinkFlutterGems;

  /// No description provided for @helpfulLinkUndraw.
  ///
  /// In en, this message translates to:
  /// **'unDraw Illustrations'**
  String get helpfulLinkUndraw;

  /// No description provided for @helpfulLinkSvgRepo.
  ///
  /// In en, this message translates to:
  /// **'SVG Repo'**
  String get helpfulLinkSvgRepo;

  /// No description provided for @helpfulLinkAwesomeFlutter.
  ///
  /// In en, this message translates to:
  /// **'Awesome Flutter (GitHub)'**
  String get helpfulLinkAwesomeFlutter;

  /// No description provided for @helpfulLinkFlutterAwesome.
  ///
  /// In en, this message translates to:
  /// **'Flutter Awesome'**
  String get helpfulLinkFlutterAwesome;

  /// No description provided for @currentValue.
  ///
  /// In en, this message translates to:
  /// **'Current: {value}'**
  String currentValue(String value);

  /// No description provided for @notSet.
  ///
  /// In en, this message translates to:
  /// **'Not set'**
  String get notSet;

  /// No description provided for @confirmRevert.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to revert this step?'**
  String get confirmRevert;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fa'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fa':
      return AppLocalizationsFa();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
