import 'dart:io';

class EnvService {
  // ─── Read ──────────────────────────────────────────────────────────────────

  static String? getCurrentPubHostedUrl() =>
      Platform.environment['PUB_HOSTED_URL'];

  static String? getCurrentFlutterStorageUrl() =>
      Platform.environment['FLUTTER_STORAGE_BASE_URL'];

  // ─── Set ───────────────────────────────────────────────────────────────────

  static Future<void> setEnvVars({
    required String pubHostedUrl,
    required String flutterStorageBaseUrl,
  }) async {
    if (Platform.isWindows) {
      await _runCommand('setx', ['PUB_HOSTED_URL', pubHostedUrl]);
      await _runCommand('setx', [
        'FLUTTER_STORAGE_BASE_URL',
        flutterStorageBaseUrl,
      ]);
    } else {
      // Linux & macOS: write to ~/.profile and ~/.bashrc / ~/.zshrc
      await _writeUnixEnvVars(pubHostedUrl, flutterStorageBaseUrl);
    }
  }

  // ─── Revert ────────────────────────────────────────────────────────────────

  static Future<void> revertEnvVars() async {
    if (Platform.isWindows) {
      await _runCommand('REG', [
        'DELETE',
        r'HKCU\Environment',
        '/V',
        'PUB_HOSTED_URL',
        '/F',
      ]);
      await _runCommand('REG', [
        'DELETE',
        r'HKCU\Environment',
        '/V',
        'FLUTTER_STORAGE_BASE_URL',
        '/F',
      ]);
    } else {
      await _removeUnixEnvVars();
    }
  }

  // ─── Check ─────────────────────────────────────────────────────────────────

  /// Returns true if the persistent env vars on disk match the given values.
  static Future<bool> envVarsMatch({
    required String pubHostedUrl,
    required String flutterStorageBaseUrl,
  }) async {
    if (Platform.isWindows) {
      final pub = await _readWindowsEnvVar('PUB_HOSTED_URL');
      final storage = await _readWindowsEnvVar('FLUTTER_STORAGE_BASE_URL');
      return pub == pubHostedUrl && storage == flutterStorageBaseUrl;
    } else {
      final rcFile = await _getUnixRcFile();
      if (!await rcFile.exists()) return false;
      final content = await rcFile.readAsString();
      return content.contains('PUB_HOSTED_URL="$pubHostedUrl"') &&
          content.contains('FLUTTER_STORAGE_BASE_URL="$flutterStorageBaseUrl"');
    }
  }

  // ─── Private helpers ───────────────────────────────────────────────────────

  static Future<void> _runCommand(String exe, List<String> args) async {
    final result = await Process.run(exe, args, runInShell: true);
    if (result.exitCode != 0) {
      throw Exception(
        'Command failed: $exe ${args.join(' ')}\n${result.stderr}',
      );
    }
  }

  static Future<String?> _readWindowsEnvVar(String name) async {
    final result = await Process.run('REG', [
      'QUERY',
      r'HKCU\Environment',
      '/V',
      name,
    ], runInShell: true);
    if (result.exitCode != 0) return null;
    final output = result.stdout as String;
    final lines = output.split('\n');
    for (final line in lines) {
      if (line.trim().startsWith(name)) {
        final parts = line.trim().split(RegExp(r'\s{2,}'));
        if (parts.length >= 3) return parts.last.trim();
      }
    }
    return null;
  }

  static Future<File> _getUnixRcFile() async {
    final home = Platform.environment['HOME'] ?? '';
    final shell = Platform.environment['SHELL'] ?? '';
    if (shell.contains('zsh')) {
      return File('$home/.zshrc');
    }
    return File('$home/.bashrc');
  }

  static const String _startMarker = '# >>> flutter_freedom env vars >>>';
  static const String _endMarker = '# <<< flutter_freedom env vars <<<';

  static Future<void> _writeUnixEnvVars(
    String pubUrl,
    String storageUrl,
  ) async {
    final rcFile = await _getUnixRcFile();
    String content = rcFile.existsSync() ? await rcFile.readAsString() : '';

    // Remove existing block if present
    content = _removeMarkerBlock(content);

    final block =
        '\n$_startMarker\n'
        'export PUB_HOSTED_URL="$pubUrl"\n'
        'export FLUTTER_STORAGE_BASE_URL="$storageUrl"\n'
        '$_endMarker\n';

    await rcFile.writeAsString(content + block);

    // Also write to ~/.profile for broader compatibility
    final profileFile = File('${Platform.environment['HOME'] ?? ''}/.profile');
    String profileContent = profileFile.existsSync()
        ? await profileFile.readAsString()
        : '';
    profileContent = _removeMarkerBlock(profileContent);
    await profileFile.writeAsString(profileContent + block);
  }

  static Future<void> _removeUnixEnvVars() async {
    final rcFile = await _getUnixRcFile();
    if (rcFile.existsSync()) {
      final content = await rcFile.readAsString();
      await rcFile.writeAsString(_removeMarkerBlock(content));
    }
    final profileFile = File('${Platform.environment['HOME'] ?? ''}/.profile');
    if (profileFile.existsSync()) {
      final content = await profileFile.readAsString();
      await profileFile.writeAsString(_removeMarkerBlock(content));
    }
  }

  static String _removeMarkerBlock(String content) {
    final start = content.indexOf(_startMarker);
    final end = content.indexOf(_endMarker);
    if (start == -1 || end == -1) return content;
    return content.substring(0, start) +
        content.substring(end + _endMarker.length);
  }
}
