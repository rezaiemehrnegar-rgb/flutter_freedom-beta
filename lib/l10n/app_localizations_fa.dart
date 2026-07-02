// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Persian (`fa`).
class AppLocalizationsFa extends AppLocalizations {
  AppLocalizationsFa([String locale = 'fa']) : super(locale);

  @override
  String get appTitle => 'فلاتر فریدم';

  @override
  String get languageToggle => 'English';

  @override
  String get sectionDownloadLinks => 'لینک‌های دانلود';

  @override
  String get sectionMirrorSetup => 'تنظیم میرور';

  @override
  String get sectionHelpfulLinks => 'لینک‌های مفید';

  @override
  String get downloadFlutterSdk => 'دانلود Flutter SDK';

  @override
  String get downloadAndroidSdk => 'دانلود Android SDK';

  @override
  String get stepEnvVars => 'مرحله ۱ — متغیرهای محیطی';

  @override
  String get stepGradleInit => 'مرحله ۲ — اسکریپت Init گریدل';

  @override
  String get stepGradleWrapper => 'مرحله ۳ — فایل Gradle Wrapper';

  @override
  String get stepEnvVarsDesc =>
      'متغیرهای محیطی PUB_HOSTED_URL و FLUTTER_STORAGE_BASE_URL را در سیستم تنظیم می‌کند.';

  @override
  String get stepGradleInitDesc =>
      'فایل mirror.init.gradle.kts را در پوشه .gradle/init.d ایجاد می‌کند تا مخازن Maven را هدایت کند.';

  @override
  String get stepGradleWrapperDesc =>
      'فایل gradle-wrapper.properties پروژه فلاتر شما را برای دانلود گریدل از میرور به‌روز می‌کند.';

  @override
  String get selectMirror => 'انتخاب میرور';

  @override
  String get applyMirror => 'اعمال';

  @override
  String get revertMirror => 'بازگردانی';

  @override
  String get autoSetup => 'تنظیم خودکار (مرحله ۱ و ۲)';

  @override
  String get autoSetupDesc =>
      'به‌صورت خودکار میرور مایکت را برای متغیرهای محیطی و اسکریپت گریدل اعمال می‌کند.';

  @override
  String get selectProjectFolder => 'انتخاب پوشه پروژه فلاتر';

  @override
  String folderSelected(String path) {
    return 'پوشه: $path';
  }

  @override
  String get noFolderSelected => 'پوشه‌ای انتخاب نشده';

  @override
  String get statusApplied => 'اعمال شده';

  @override
  String get statusNotApplied => 'اعمال نشده';

  @override
  String get successEnvSet => 'متغیرهای محیطی با موفقیت تنظیم شدند.';

  @override
  String get successEnvReverted => 'متغیرهای محیطی بازگردانی شدند.';

  @override
  String get successFileCreated => 'فایل init گریدل ایجاد شد.';

  @override
  String get successFileChanged => 'فایل init گریدل به‌روز شد.';

  @override
  String get successFileRemoved => 'فایل init گریدل حذف شد.';

  @override
  String get successWrapperUpdated =>
      'فایل gradle-wrapper.properties به‌روز شد.';

  @override
  String get successWrapperReverted =>
      'فایل gradle-wrapper.properties به منبع رسمی بازگردانی شد.';

  @override
  String get errorUserFolderNotFound => 'پوشه کاربر یافت نشد.';

  @override
  String get errorFileNotExist => 'فایل وجود ندارد.';

  @override
  String get errorFileAlreadyCorrect => 'فایل از قبل روی این میرور تنظیم شده.';

  @override
  String get errorWrapperNotFound =>
      'فایل gradle-wrapper.properties در پوشه انتخاب‌شده یافت نشد.';

  @override
  String get errorWrapperReadFailed =>
      'خواندن فایل gradle-wrapper.properties ناموفق بود.';

  @override
  String errorGeneric(String message) {
    return 'خطایی رخ داد: $message';
  }

  @override
  String get errorNoFolderSelected =>
      'لطفاً ابتدا پوشه پروژه فلاتر را انتخاب کنید.';

  @override
  String get errorAdminRequired =>
      'این عملیات ممکن است به دسترسی مدیر در ویندوز نیاز داشته باشد.';

  @override
  String errorAutoSetupFailed(String message) {
    return 'تنظیم خودکار ناموفق بود: $message';
  }

  @override
  String get autoSetupSuccess => 'تنظیم خودکار با موفقیت انجام شد.';

  @override
  String get mirrorMyket => 'مایکت';

  @override
  String get mirrorRunflare => 'رانفلر';

  @override
  String get mirrorChinese => 'چینی';

  @override
  String get mirrorTaraz => 'تراز';

  @override
  String get mirrorDevNeeds => 'دِو‌نیدز';

  @override
  String get helpfulLinkPubMyket => 'میرور pub.dev (مایکت)';

  @override
  String get helpfulLinkPubTaraz => 'میرور pub.dev (تراز)';

  @override
  String get helpfulLinkMavenMyket => 'مستندات میرورهای مایکت';

  @override
  String get helpfulLinkRunflareDocs => 'مستندات میرورهای رانفلر';

  @override
  String get helpfulLinkFlutterGems => 'Flutter Gems';

  @override
  String get helpfulLinkUndraw => 'تصویرسازی‌های unDraw';

  @override
  String get helpfulLinkSvgRepo => 'SVG Repo';

  @override
  String get helpfulLinkAwesomeFlutter => 'Awesome Flutter (گیت‌هاب)';

  @override
  String get helpfulLinkFlutterAwesome => 'Flutter Awesome';

  @override
  String currentValue(String value) {
    return 'مقدار فعلی: $value';
  }

  @override
  String get notSet => 'تنظیم نشده';

  @override
  String get confirmRevert =>
      'آیا مطمئنید که می‌خواهید این مرحله را بازگردانی کنید؟';

  @override
  String get yes => 'بله';

  @override
  String get cancel => 'لغو';
}
