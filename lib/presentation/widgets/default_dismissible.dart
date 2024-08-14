import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scoring_pad/presentation/app_color_schemes.dart';
import 'package:scoring_pad/presentation/graphic_tools.dart';

class DefaultDismissible extends ConsumerWidget {
  final IconData icon;
  final Function() onDismissed;
  final ConfirmDismissCallback? confirmDismiss;
  final Widget child;

  const DefaultDismissible(
      {required super.key, required this.icon, required this.onDismissed, this.confirmDismiss, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final enabled = ref.watch(dismissibleStateProvider);
    final scheme = Theme.of(context).colorScheme.dismissibleScheme;
    final background = enabled ? scheme.enabledBackground : scheme.disabledBackground;
    final iconColor = computeColorForText(background);
    return Dismissible(
      key: key!,
      background: Container(
        alignment: AlignmentDirectional.centerEnd,
        color: background,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(icon, color: iconColor),
        ),
      ),
      direction: DismissDirection.endToStart,
      onUpdate: (details) {
        if (details.reached && !details.previousReached) {
          ref.read(dismissibleStateProvider.notifier).enable();
        } else if (!details.reached && details.previousReached) {
          ref.read(dismissibleStateProvider.notifier).disable();
        }
      },
      onDismissed: (direction) {
        onDismissed();
      },
      confirmDismiss: confirmDismiss,
      child: child,
    );
  }
}

class DismissibleStateNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void enable() {
    state = true;
  }

  void disable() {
    state = false;
  }
}

final dismissibleStateProvider = NotifierProvider<DismissibleStateNotifier, bool>(
  DismissibleStateNotifier.new,
);
