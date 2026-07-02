import 'dart:io';
import 'package:path/path.dart' as p;

class GradleWrapperService {
  static const String _officialBase =
      r'https\://services.gradle.org/distributions/gradle-';

  static File _getWrapperFile(String projectPath) {
    return File(
      p.join(
        projectPath,
        'android',
        'gradle',
        'wrapper',
        'gradle-wrapper.properties',
      ),
    );
  }

  // ─── Read current distributionUrl ─────────────────────────────────────────

  static Future<String?> readDistributionUrl(String projectPath) async {
    final file = _getWrapperFile(projectPath);
    if (!await file.exists()) return null;
    final lines = await file.readAsLines();
    for (final line in lines) {
      if (line.trimLeft().startsWith('distributionUrl=')) {
        return line.substring('distributionUrl='.length).trim();
      }
    }
    return null;
  }

  // ─── Extract gradle version string from the URL ───────────────────────────
  // e.g. "gradle-8.13-bin.zip" → "8.13-bin"
  // Handles both official and mirrored URLs.

  static String? extractVersion(String distributionUrl) {
    final decoded = distributionUrl.replaceAll(r'\:', ':');
    final gradleIdx = decoded.lastIndexOf('gradle-');
    if (gradleIdx == -1) return null;
    final after = decoded.substring(gradleIdx + 'gradle-'.length);
    final zipIdx = after.lastIndexOf('.zip');
    if (zipIdx == -1) return null;
    return after.substring(0, zipIdx); // e.g. "8.13-bin"
  }

  // ─── Apply mirror ──────────────────────────────────────────────────────────

  /// [urlTemplate] must contain {version} placeholder.
  /// Returns the version string that was found and kept.
  static Future<String> applyMirror({
    required String projectPath,
    required String urlTemplate,
  }) async {
    final file = _getWrapperFile(projectPath);
    if (!await file.exists()) throw Exception('wrapperNotFound');

    final lines = await file.readAsLines();
    String? version;
    final newLines = <String>[];

    for (final line in lines) {
      if (line.trimLeft().startsWith('distributionUrl=')) {
        final currentUrl = line.substring('distributionUrl='.length).trim();
        version = extractVersion(currentUrl);
        if (version == null) throw Exception('wrapperReadFailed');
        final newUrl = urlTemplate.replaceAll('{version}', version);
        newLines.add('distributionUrl=$newUrl');
      } else {
        newLines.add(line);
      }
    }

    if (version == null) throw Exception('wrapperReadFailed');
    await file.writeAsString(newLines.join('\n'));
    return version;
  }

  // ─── Revert to official ────────────────────────────────────────────────────

  static Future<String> revertToOfficial(String projectPath) async {
    final file = _getWrapperFile(projectPath);
    if (!await file.exists()) throw Exception('wrapperNotFound');

    final lines = await file.readAsLines();
    String? version;
    final newLines = <String>[];

    for (final line in lines) {
      if (line.trimLeft().startsWith('distributionUrl=')) {
        final currentUrl = line.substring('distributionUrl='.length).trim();
        version = extractVersion(currentUrl);
        if (version == null) throw Exception('wrapperReadFailed');
        newLines.add('distributionUrl=$_officialBase$version.zip');
      } else {
        newLines.add(line);
      }
    }

    if (version == null) throw Exception('wrapperReadFailed');
    await file.writeAsString(newLines.join('\n'));
    return version;
  }

  // ─── Check if currently using a mirror ────────────────────────────────────

  static Future<bool> isUsingMirror(String projectPath) async {
    final url = await readDistributionUrl(projectPath);
    if (url == null) return false;
    return !url.contains('services.gradle.org');
  }
}
