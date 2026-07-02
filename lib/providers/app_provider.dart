import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/mirrors.dart';
import '../services/env_service.dart';
import '../services/gradle_init_service.dart';
import '../services/gradle_wrapper_service.dart';

enum OpStatus { idle, loading, success, error }

class AppProvider extends ChangeNotifier {
  // ─── Language ──────────────────────────────────────────────────────────────
  Locale _locale = const Locale('fa');
  Locale get locale => _locale;

  // ─── Step 1 state ──────────────────────────────────────────────────────────
  EnvMirror _selectedEnvMirror = EnvMirror.myket;
  EnvMirror get selectedEnvMirror => _selectedEnvMirror;
  OpStatus _envStatus = OpStatus.idle;
  OpStatus get envStatus => _envStatus;
  String _envMessage = '';
  String get envMessage => _envMessage;

  // ─── Step 2 state ──────────────────────────────────────────────────────────
  GradleInitMirror _selectedGradleInitMirror = GradleInitMirror.myket;
  GradleInitMirror get selectedGradleInitMirror => _selectedGradleInitMirror;
  OpStatus _gradleInitStatus = OpStatus.idle;
  OpStatus get gradleInitStatus => _gradleInitStatus;
  String _gradleInitMessage = '';
  String get gradleInitMessage => _gradleInitMessage;

  // ─── Step 3 state ──────────────────────────────────────────────────────────
  GradleWrapperMirror _selectedWrapperMirror = GradleWrapperMirror.myket;
  GradleWrapperMirror get selectedWrapperMirror => _selectedWrapperMirror;
  OpStatus _wrapperStatus = OpStatus.idle;
  OpStatus get wrapperStatus => _wrapperStatus;
  String _wrapperMessage = '';
  String get wrapperMessage => _wrapperMessage;
  String? _selectedProjectPath;
  String? get selectedProjectPath => _selectedProjectPath;

  // ─── Auto setup state ──────────────────────────────────────────────────────
  OpStatus _autoSetupStatus = OpStatus.idle;
  OpStatus get autoSetupStatus => _autoSetupStatus;
  String _autoSetupMessage = '';
  String get autoSetupMessage => _autoSetupMessage;

  // ─── Init ──────────────────────────────────────────────────────────────────
  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final langCode = prefs.getString('locale') ?? 'fa';
    _locale = Locale(langCode);
    notifyListeners();
  }

  // ─── Language ──────────────────────────────────────────────────────────────
  Future<void> toggleLocale() async {
    _locale = _locale.languageCode == 'fa'
        ? const Locale('en')
        : const Locale('fa');
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('locale', _locale.languageCode);
    notifyListeners();
  }

  // ─── Step 1 ────────────────────────────────────────────────────────────────
  void setEnvMirror(EnvMirror mirror) {
    _selectedEnvMirror = mirror;
    notifyListeners();
  }

  Future<void> applyEnvMirror() async {
    _envStatus = OpStatus.loading;
    _envMessage = '';
    notifyListeners();
    try {
      final data = envMirrors.firstWhere((m) => m.mirror == _selectedEnvMirror);
      await EnvService.setEnvVars(
        pubHostedUrl: data.pubHostedUrl,
        flutterStorageBaseUrl: data.flutterStorageBaseUrl,
      );
      _envStatus = OpStatus.success;
      _envMessage = 'successEnvSet';
    } catch (e) {
      _envStatus = OpStatus.error;
      _envMessage = e.toString();
    }
    notifyListeners();
  }

  Future<void> revertEnvMirror() async {
    _envStatus = OpStatus.loading;
    _envMessage = '';
    notifyListeners();
    try {
      await EnvService.revertEnvVars();
      _envStatus = OpStatus.success;
      _envMessage = 'successEnvReverted';
    } catch (e) {
      _envStatus = OpStatus.error;
      _envMessage = e.toString();
    }
    notifyListeners();
  }

  // ─── Step 2 ────────────────────────────────────────────────────────────────
  void setGradleInitMirror(GradleInitMirror mirror) {
    _selectedGradleInitMirror = mirror;
    notifyListeners();
  }

  Future<void> applyGradleInitMirror() async {
    _gradleInitStatus = OpStatus.loading;
    _gradleInitMessage = '';
    notifyListeners();
    try {
      final data = gradleInitMirrors.firstWhere(
        (m) => m.mirror == _selectedGradleInitMirror,
      );
      final result = await GradleInitService.applyMirror(data.fileContent);
      _gradleInitStatus = OpStatus.success;
      _gradleInitMessage = result == 'created'
          ? 'successFileCreated'
          : result == 'updated'
          ? 'successFileChanged'
          : 'errorFileAlreadyCorrect';
    } catch (e) {
      _gradleInitStatus = OpStatus.error;
      _gradleInitMessage = e.toString();
    }
    notifyListeners();
  }

  Future<void> revertGradleInitMirror() async {
    _gradleInitStatus = OpStatus.loading;
    _gradleInitMessage = '';
    notifyListeners();
    try {
      final deleted = await GradleInitService.revertMirror();
      _gradleInitStatus = OpStatus.success;
      _gradleInitMessage = deleted ? 'successFileRemoved' : 'errorFileNotExist';
    } catch (e) {
      _gradleInitStatus = OpStatus.error;
      _gradleInitMessage = e.toString();
    }
    notifyListeners();
  }

  // ─── Step 3 ────────────────────────────────────────────────────────────────
  void setWrapperMirror(GradleWrapperMirror mirror) {
    _selectedWrapperMirror = mirror;
    notifyListeners();
  }

  void setProjectPath(String path) {
    _selectedProjectPath = path;
    _wrapperStatus = OpStatus.idle;
    _wrapperMessage = '';
    notifyListeners();
  }

  Future<void> applyWrapperMirror() async {
    if (_selectedProjectPath == null) {
      _wrapperStatus = OpStatus.error;
      _wrapperMessage = 'errorNoFolderSelected';
      notifyListeners();
      return;
    }
    _wrapperStatus = OpStatus.loading;
    _wrapperMessage = '';
    notifyListeners();
    try {
      final data = gradleWrapperMirrors.firstWhere(
        (m) => m.mirror == _selectedWrapperMirror,
      );
      await GradleWrapperService.applyMirror(
        projectPath: _selectedProjectPath!,
        urlTemplate: data.distributionUrlTemplate,
      );
      _wrapperStatus = OpStatus.success;
      _wrapperMessage = 'successWrapperUpdated';
    } catch (e) {
      _wrapperStatus = OpStatus.error;
      _wrapperMessage = _mapException(e.toString());
    }
    notifyListeners();
  }

  Future<void> revertWrapperMirror() async {
    if (_selectedProjectPath == null) {
      _wrapperStatus = OpStatus.error;
      _wrapperMessage = 'errorNoFolderSelected';
      notifyListeners();
      return;
    }
    _wrapperStatus = OpStatus.loading;
    _wrapperMessage = '';
    notifyListeners();
    try {
      await GradleWrapperService.revertToOfficial(_selectedProjectPath!);
      _wrapperStatus = OpStatus.success;
      _wrapperMessage = 'successWrapperReverted';
    } catch (e) {
      _wrapperStatus = OpStatus.error;
      _wrapperMessage = _mapException(e.toString());
    }
    notifyListeners();
  }

  // ─── Auto Setup ────────────────────────────────────────────────────────────
  Future<void> runAutoSetup() async {
    _autoSetupStatus = OpStatus.loading;
    _autoSetupMessage = '';
    notifyListeners();
    try {
      // Step 1: env vars with Myket
      final envData = envMirrors.firstWhere(
        (m) => m.mirror == autoSetupEnvMirror,
      );
      await EnvService.setEnvVars(
        pubHostedUrl: envData.pubHostedUrl,
        flutterStorageBaseUrl: envData.flutterStorageBaseUrl,
      );
      // Step 2: gradle init with Myket
      final gradleData = gradleInitMirrors.firstWhere(
        (m) => m.mirror == autoSetupGradleInitMirror,
      );
      await GradleInitService.applyMirror(gradleData.fileContent);

      _autoSetupStatus = OpStatus.success;
      _autoSetupMessage = 'autoSetupSuccess';

      // Also reflect the applied mirrors in step 1 & 2 selectors
      _selectedEnvMirror = autoSetupEnvMirror;
      _envStatus = OpStatus.success;
      _envMessage = 'successEnvSet';
      _selectedGradleInitMirror = autoSetupGradleInitMirror;
      _gradleInitStatus = OpStatus.success;
      _gradleInitMessage = 'successFileCreated';
    } catch (e) {
      _autoSetupStatus = OpStatus.error;
      _autoSetupMessage = e.toString();
    }
    notifyListeners();
  }

  // ─── Helpers ───────────────────────────────────────────────────────────────
  String _mapException(String raw) {
    if (raw.contains('wrapperNotFound')) return 'errorWrapperNotFound';
    if (raw.contains('wrapperReadFailed')) return 'errorWrapperReadFailed';
    if (raw.contains('userHomeFolderNotFound')) {
      return 'errorUserFolderNotFound';
    }
    return raw;
  }
}
