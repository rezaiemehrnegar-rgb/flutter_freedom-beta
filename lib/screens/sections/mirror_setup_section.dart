import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_freedom/generated/app_localizations.dart';
import '../../providers/app_provider.dart';
import '../../constants/mirrors.dart';

//TODO fix folder picker on linux
class MirrorSetupSection extends StatelessWidget {
  const MirrorSetupSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final provider = context.watch<AppProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // ── Auto Setup Button (Shelved for now) ───────────────────────────────────────────────
        // _AutoSetupCard(l10n: l10n, provider: provider),
        // const SizedBox(height: 28),

        // ── Description ─────────────────────────────────────────────────────
        Text(
          l10n.mirrorSetupDesc,
          style: const TextStyle(fontSize: 13, color: Color(0xFF70788A)),
        ),
        const SizedBox(height: 16),
        // ── Step 1 ──────────────────────────────────────────────────────────
        _StepCard(
          stepNumber: '1',
          title: l10n.stepEnvVars,
          description: l10n.stepEnvVarsDesc,
          child: _EnvVarStep(l10n: l10n, provider: provider),
        ),
        const SizedBox(height: 16),

        // ── Step 2 ──────────────────────────────────────────────────────────
        _StepCard(
          stepNumber: '2',
          title: l10n.stepGradleInit,
          description: l10n.stepGradleInitDesc,
          child: _GradleInitStep(l10n: l10n, provider: provider),
        ),
        const SizedBox(height: 16),

        // ── Step 3 ──────────────────────────────────────────────────────────
        _StepCard(
          stepNumber: '3',
          title: l10n.stepGradleWrapper,
          description: l10n.stepGradleWrapperDesc,
          child: _GradleWrapperStep(l10n: l10n, provider: provider),
        ),
      ],
    );
  }
}

// ─── Auto Setup Card ──────────────────────────────────────────────────────────
//! "Auto Setup Card" widget is shelved for different reasons but is functional. uncomment lines 21:22 to use it
// ignore: unused_element
class _AutoSetupCard extends StatelessWidget {
  final AppLocalizations l10n;
  final AppProvider provider;

  const _AutoSetupCard({required this.l10n, required this.provider});

  @override
  Widget build(BuildContext context) {
    final isLoading = provider.autoSetupStatus == OpStatus.loading;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1E3A5F), Color(0xFF1A2A4A)],
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFF54C5F8).withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.auto_fix_high_rounded,
            color: Color(0xFF54C5F8),
            size: 28,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.autoSetup,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Color(0xFFE0E0E0),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.autoSetupDesc,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF90A0B0),
                  ),
                ),
                if (provider.autoSetupStatus != OpStatus.idle) ...[
                  const SizedBox(height: 8),
                  _StatusChip(
                    status: provider.autoSetupStatus,
                    messageKey: provider.autoSetupMessage,
                    l10n: l10n,
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 16),
          isLoading
              ? const SizedBox(
                  width: 36,
                  height: 36,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : ElevatedButton(
                  onPressed: () async {
                    await provider.runAutoSetup();
                    _showToast(
                      context,
                      provider.autoSetupStatus,
                      provider.autoSetupMessage,
                      l10n,
                    );
                  },
                  child: Text(
                    l10n.autoSetup.split(' ').first,
                  ), // short label "Auto Setup"
                ),
        ],
      ),
    );
  }
}

// ─── Step Card wrapper ────────────────────────────────────────────────────────

class _StepCard extends StatelessWidget {
  final String stepNumber;
  final String title;
  final String description;
  final Widget child;

  const _StepCard({
    required this.stepNumber,
    required this.title,
    required this.description,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF16162A),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF2A2A40)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: const Color(0xFF54C5F8).withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFF54C5F8).withValues(alpha: 0.5),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  stepNumber,
                  style: const TextStyle(
                    color: Color(0xFF54C5F8),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(fontSize: 12, color: Color(0xFF70788A)),
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

// ─── Step 1: Env Vars ─────────────────────────────────────────────────────────

class _EnvVarStep extends StatelessWidget {
  final AppLocalizations l10n;
  final AppProvider provider;

  const _EnvVarStep({required this.l10n, required this.provider});

  @override
  Widget build(BuildContext context) {
    final isLoading = provider.envStatus == OpStatus.loading;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Mirror selector chips
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: envMirrors.map((m) {
            final selected = provider.selectedEnvMirror == m.mirror;
            return ChoiceChip(
              label: Text(_mirrorName(m.name, l10n)),
              selected: selected,
              onSelected: (_) => provider.setEnvMirror(m.mirror),
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
        // Buttons
        _ActionRow(
          isLoading: isLoading,
          onApply: () async {
            await provider.applyEnvMirror();
            _showToast(context, provider.envStatus, provider.envMessage, l10n);
          },
          onRevert: () async {
            final confirmed = await _confirmRevert(context, l10n);
            if (!confirmed) return;
            await provider.revertEnvMirror();
            _showToast(context, provider.envStatus, provider.envMessage, l10n);
          },
          l10n: l10n,
        ),
        if (provider.envStatus != OpStatus.idle) ...[
          const SizedBox(height: 12),
          _StatusChip(
            status: provider.envStatus,
            messageKey: provider.envMessage,
            l10n: l10n,
          ),
        ],
      ],
    );
  }
}

// ─── Step 2: Gradle Init ──────────────────────────────────────────────────────

class _GradleInitStep extends StatelessWidget {
  final AppLocalizations l10n;
  final AppProvider provider;

  const _GradleInitStep({required this.l10n, required this.provider});

  @override
  Widget build(BuildContext context) {
    final isLoading = provider.gradleInitStatus == OpStatus.loading;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: gradleInitMirrors.map((m) {
            final selected = provider.selectedGradleInitMirror == m.mirror;
            return ChoiceChip(
              label: Text(_mirrorName(m.name, l10n)),
              selected: selected,
              onSelected: (_) => provider.setGradleInitMirror(m.mirror),
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
        _ActionRow(
          isLoading: isLoading,
          onApply: () async {
            await provider.applyGradleInitMirror();
            _showToast(
              context,
              provider.gradleInitStatus,
              provider.gradleInitMessage,
              l10n,
            );
          },
          onRevert: () async {
            final confirmed = await _confirmRevert(context, l10n);
            if (!confirmed) return;
            await provider.revertGradleInitMirror();
            _showToast(
              context,
              provider.gradleInitStatus,
              provider.gradleInitMessage,
              l10n,
            );
          },
          l10n: l10n,
        ),
        if (provider.gradleInitStatus != OpStatus.idle) ...[
          const SizedBox(height: 12),
          _StatusChip(
            status: provider.gradleInitStatus,
            messageKey: provider.gradleInitMessage,
            l10n: l10n,
          ),
        ],
      ],
    );
  }
}

// ─── Step 3: Gradle Wrapper ───────────────────────────────────────────────────

class _GradleWrapperStep extends StatelessWidget {
  final AppLocalizations l10n;
  final AppProvider provider;

  const _GradleWrapperStep({required this.l10n, required this.provider});

  @override
  Widget build(BuildContext context) {
    final isLoading = provider.wrapperStatus == OpStatus.loading;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Mirror selector
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: gradleWrapperMirrors.map((m) {
            final selected = provider.selectedWrapperMirror == m.mirror;
            return ChoiceChip(
              label: Text(_mirrorName(m.name, l10n)),
              selected: selected,
              onSelected: (_) => provider.setWrapperMirror(m.mirror),
            );
          }).toList(),
        ),
        const SizedBox(height: 16),

        // Folder picker
        Row(
          children: [
            OutlinedButton.icon(
              icon: const Icon(Icons.folder_open_rounded, size: 18),
              label: Text(l10n.selectProjectFolder),
              onPressed: () async {
                final result = await FilePicker.platform.getDirectoryPath();
                if (result != null) provider.setProjectPath(result);
              },
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                provider.selectedProjectPath != null
                    ? l10n.folderSelected(provider.selectedProjectPath!)
                    : l10n.noFolderSelected,
                style: const TextStyle(fontSize: 12, color: Color(0xFF70788A)),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        _ActionRow(
          isLoading: isLoading,
          onApply: () async {
            await provider.applyWrapperMirror();
            _showToast(
              context,
              provider.wrapperStatus,
              provider.wrapperMessage,
              l10n,
            );
          },
          onRevert: () async {
            final confirmed = await _confirmRevert(context, l10n);
            if (!confirmed) return;
            await provider.revertWrapperMirror();
            _showToast(
              context,
              provider.wrapperStatus,
              provider.wrapperMessage,
              l10n,
            );
          },
          l10n: l10n,
        ),
        if (provider.wrapperStatus != OpStatus.idle) ...[
          const SizedBox(height: 12),
          _StatusChip(
            status: provider.wrapperStatus,
            messageKey: provider.wrapperMessage,
            l10n: l10n,
          ),
        ],
      ],
    );
  }
}

// ─── Shared widgets ───────────────────────────────────────────────────────────

class _ActionRow extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onApply;
  final VoidCallback onRevert;
  final AppLocalizations l10n;

  const _ActionRow({
    required this.isLoading,
    required this.onApply,
    required this.onRevert,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : ElevatedButton(onPressed: onApply, child: Text(l10n.applyMirror)),
        const SizedBox(width: 12),
        OutlinedButton(
          onPressed: isLoading ? null : onRevert,
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color(0xFFFF6B6B),
            side: const BorderSide(color: Color(0xFFFF6B6B)),
          ),
          child: Text(l10n.revertMirror),
        ),
      ],
    );
  }
}

class _StatusChip extends StatelessWidget {
  final OpStatus status;
  final String messageKey;
  final AppLocalizations l10n;

  const _StatusChip({
    required this.status,
    required this.messageKey,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    final isSuccess = status == OpStatus.success;
    final color = isSuccess ? const Color(0xFF78C257) : const Color(0xFFFF6B6B);
    final icon = isSuccess ? Icons.check_circle_outline : Icons.error_outline;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 16),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            _resolveMessage(messageKey, l10n),
            style: TextStyle(color: color, fontSize: 13),
          ),
        ),
      ],
    );
  }
}

// ─── Helpers ──────────────────────────────────────────────────────────────────

String _mirrorName(String key, AppLocalizations l10n) {
  switch (key) {
    case 'mirrorMyket':
      return l10n.mirrorMyket;
    case 'mirrorRunflare':
      return l10n.mirrorRunflare;
    case 'mirrorChinese':
      return l10n.mirrorChinese;
    case 'mirrorTaraz':
      return l10n.mirrorTaraz;
    case 'mirrorDevNeeds':
      return l10n.mirrorDevNeeds;
    default:
      return key;
  }
}

String _resolveMessage(String key, AppLocalizations l10n) {
  switch (key) {
    case 'successEnvSet':
      return l10n.successEnvSet;
    case 'successEnvReverted':
      return l10n.successEnvReverted;
    case 'successFileCreated':
      return l10n.successFileCreated;
    case 'successFileChanged':
      return l10n.successFileChanged;
    case 'successFileRemoved':
      return l10n.successFileRemoved;
    case 'successWrapperUpdated':
      return l10n.successWrapperUpdated;
    case 'successWrapperReverted':
      return l10n.successWrapperReverted;
    case 'errorFileAlreadyCorrect':
      return l10n.errorFileAlreadyCorrect;
    case 'errorFileNotExist':
      return l10n.errorFileNotExist;
    case 'errorWrapperNotFound':
      return l10n.errorWrapperNotFound;
    case 'errorWrapperReadFailed':
      return l10n.errorWrapperReadFailed;
    case 'errorUserFolderNotFound':
      return l10n.errorUserFolderNotFound;
    case 'errorNoFolderSelected':
      return l10n.errorNoFolderSelected;
    case 'autoSetupSuccess':
      return l10n.autoSetupSuccess;
    default:
      return l10n.errorGeneric(key);
  }
}

void _showToast(
  BuildContext context,
  OpStatus status,
  String messageKey,
  AppLocalizations l10n,
) {
  final isSuccess = status == OpStatus.success;
  BotToast.showSimpleNotification(
    title: _resolveMessage(messageKey, l10n),
    backgroundColor: isSuccess
        ? const Color(0xFF2D5A27)
        : const Color(0xFF5A2727),
    titleStyle: const TextStyle(color: Colors.white, fontSize: 13),
    duration: const Duration(seconds: 3),
    align: Alignment.bottomCenter,
  );
}

Future<bool> _confirmRevert(BuildContext context, AppLocalizations l10n) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      backgroundColor: const Color(0xFF1E1E30),
      title: Text(
        l10n.confirmRevert,
        style: const TextStyle(color: Color(0xFFE0E0E0)),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx, false),
          child: Text(l10n.cancel),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFF6B6B),
            foregroundColor: Colors.white,
          ),
          onPressed: () => Navigator.pop(ctx, true),
          child: Text(l10n.yes),
        ),
      ],
    ),
  );
  return result ?? false;
}
