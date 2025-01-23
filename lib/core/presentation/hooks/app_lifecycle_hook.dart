import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void useAppLifecycle({
  VoidCallback? onInitialize,
  VoidCallback? onAppOpen,
  VoidCallback? onAppClosed,
}) {
  useEffect(
    () {
      onInitialize?.call();
      return () {};
    },
    const [],
  );

  useOnAppLifecycleStateChange(
    (previous, current) {
      if (previous == AppLifecycleState.hidden &&
          current == AppLifecycleState.inactive) {
        onAppOpen?.call();
      }
      if (previous == AppLifecycleState.hidden &&
          current == AppLifecycleState.paused) {
        onAppClosed?.call();
      }
    },
  );
}
