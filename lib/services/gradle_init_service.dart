import 'dart:io';
import 'package:path/path.dart' as p;

class GradleInitService {
  static const String _fileName = 'mirror.init.gradle.kts';

  static Future<File> _getMirrorFile() async {
    final home = Platform.isWindows
        ? Platform.environment['USERPROFILE']
        : Platform.environment['HOME'];

    if (home == null) throw Exception('userHomeFolderNotFound');

    final initdPath = p.join(home, '.gradle', 'init.d');
    final initdDir = Directory(initdPath);
    if (!await initdDir.exists()) {
      await initdDir.create(recursive: true);
    }
    return File(p.join(initdPath, _fileName));
  }

  // ─── Create / Update ───────────────────────────────────────────────────────

  /// Returns: 'created' | 'updated' | 'alreadyCorrect'
  static Future<String> applyMirror(String fileContent) async {
    final file = await _getMirrorFile();
    final exists = await file.exists();

    if (exists) {
      final current = await file.readAsString();
      if (current.trim() == fileContent.trim()) return 'alreadyCorrect';
      await file.writeAsString(fileContent);
      return 'updated';
    } else {
      await file.writeAsString(fileContent);
      return 'created';
    }
  }

  // ─── Remove ────────────────────────────────────────────────────────────────

  /// Returns true if the file was deleted, false if it didn't exist.
  static Future<bool> revertMirror() async {
    final file = await _getMirrorFile();
    if (await file.exists()) {
      await file.delete();
      return true;
    }
    return false;
  }

  // ─── Status ────────────────────────────────────────────────────────────────

  /// Returns the current file content or null if the file doesn't exist.
  static Future<String?> getCurrentContent() async {
    try {
      final file = await _getMirrorFile();
      if (await file.exists()) return await file.readAsString();
      return null;
    } catch (_) {
      return null;
    }
  }

  static Future<bool> isApplied(String expectedContent) async {
    final current = await getCurrentContent();
    if (current == null) return false;
    return current.trim() == expectedContent.trim();
  }
}
