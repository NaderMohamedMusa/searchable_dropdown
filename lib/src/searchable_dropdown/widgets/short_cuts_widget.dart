import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ShortCutsWidget<T> extends StatelessWidget {
  const ShortCutsWidget({
    super.key,
    required this.layerLink,
    required this.actions,
    required this.child,
  });

  final LayerLink layerLink;
  final Map<Type, Action<Intent>> actions;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: <LogicalKeySet, Intent>{
        LogicalKeySet(LogicalKeyboardKey.arrowUp, LogicalKeyboardKey.altLeft):
        const PreviousIntent(false, scrollToTop: true),
        LogicalKeySet(LogicalKeyboardKey.escape): const UnFocusIntent(),
        LogicalKeySet(LogicalKeyboardKey.arrowDown): const NextIntent(false),
        LogicalKeySet(LogicalKeyboardKey.arrowUp): const PreviousIntent(false),
      },
      child: Actions(
        actions: actions,
        child: CompositedTransformTarget(
          link: layerLink,
          child: child,
        ),
      ),
    );
  }
}