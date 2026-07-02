// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Persian (`fa`).
class AppLocalizationsFa extends AppLocalizations {
  AppLocalizationsFa([String locale = 'fa']) : super(locale);

  @override
  String get appTitle => 'آزادی فلاتر';

  @override
  String get languageToggle => 'English';

  @override
  String get currentOS => 'سیستم عامل';

  @override
  String get aboutDescription =>
      'برنامه آزادی فلاتر توسط مسعود قاسمی، جهت رفع محدودیت های موجود در برابر برنامه نویسان فلاتر در ایران ساخته شده است.\nاین برنامه تحت لیسانس GPL v3.0 به صورت OpenSource منتشر شده. هر گونه کپی برداری و استفاده از آن فقط به شرط اشتراک تغییرات به صورت رایگان بلامانع میباشد.';

  @override
  String get telegramChannel => 'کانال تلگرام';

  @override
  String get githubRepo => 'گیت‌هاب پروژه';

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
  String get stepGradleInit => 'مرحله ۲ — اسکریپت Init گریدل (میرور Maven)';

  @override
  String get stepGradleWrapper => 'مرحله ۳ — فایل Gradle Wrapper';

  @override
  String get stepEnvVarsDesc =>
      'متغیرهای محیطی PUB_HOSTED_URL و FLUTTER_STORAGE_BASE_URL را در سیستم تنظیم می‌کند.\n(برای همه پلتفرم‌ها، از جمله اندروید، لازم است)\nتوجه: ممکن است پس از اعمال این مرحله نیاز باشد IDE یا ترمینال خود را ریستارت کنید تا تغییرات اعمال شوند.\nفقط یک بار در ماشین خود انجام دهید، نه برای هر پروژه.';

  @override
  String get stepGradleInitDesc =>
      'فایل mirror.init.gradle.kts را در پوشه .gradle/init.d ایجاد می‌کند تا مخازن Maven را هدایت کند.\n(فقط برای توسعه اندروید لازم است)\nنیازمند Gradle 7.0 یا بالاتر\nبرای همه پروژه‌های مبتنی بر Gradle کار می‌کند، نه فقط فلاتر.\nمی‌تواند همراه با مرحله ۳ یا به تنهایی استفاده شود.\nفقط یک بار در ماشین خود انجام دهید، نه برای هر پروژه.';

  @override
  String get stepGradleWrapperDesc =>
      'فایل gradle-wrapper.properties پروژه فلاتر شما را برای دانلود گریدل از میرور به‌روز می‌کند.\nباید برای هر پروژه فلاتر انجام شود.\nفقط دانلودهای توزیع گریدل را تحت تأثیر قرار می‌دهد، نه وابستگی‌ها.\nدر لینوکس باید zenity نصب شده باشد (sudo apt install zenity) یا kdialog در KDE (sudo apt install kdialog)';

  @override
  String get selectMirror => 'انتخاب میرور';

  @override
  String get applyMirror => 'اعمال';

  @override
  String get revertMirror => 'حذف';

  @override
  String get autoSetup => 'تنظیم خودکار (مرحله ۱ و ۲)';

  @override
  String get autoSetupDesc =>
      'به‌صورت خودکار میرور مایکت را برای متغیرهای محیطی و اسکریپت گریدل اعمال می‌کند.';

  @override
  String get selectProjectFolder => 'انتخاب پوشه پروژه فلاتر';

  @override
  String get mirrorSetupDesc =>
      'برای توسعه اپلیکیشن‌های اندروید با فلاتر، باید مراحل ۲ و ۳ را انجام دهید، در غیر این صورت مرحله ۱ برای پروژه‌های دسکتاب و وب کافی است.';

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
  String get helpfulLinkPubMyket => 'میرور pub.dev (مایکت)';

  @override
  String get helpfulLinkPubTaraz => 'میرور pub.dev (Taraz)';

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
