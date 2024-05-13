import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loggy/loggy.dart';
import 'package:q_architecture/q_architecture.dart';

class AppBaseWidget extends ConsumerStatefulWidget {
  final Widget child;

  const AppBaseWidget(this.child, {super.key});

  @override
  ConsumerState createState() => _AppBaseWidgetState();
}

class _AppBaseWidgetState extends ConsumerState<AppBaseWidget> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      onGlobalFailure: onGlobalFailure,
      onGlobalInfo: onGlobalInfo,
      child: widget.child,
    );
  }

  void onGlobalFailure(Failure failure) {
    logError('''
        showing ${failure.isCritical ? '' : 'non-'}critical failure with 
        title ${failure.title}, 
        error: ${failure.error},
        stackTrace: ${failure.stackTrace}
      ''');
  }

  void onGlobalInfo(GlobalInfo globalInfo) {
    logInfo('''
        globalInfoStatus: ${globalInfo.globalInfoStatus}
        title: ${globalInfo.title}, 
        message: ${globalInfo.message},
      ''');
  }
}

extension _WidgetRefExtensions on WidgetRef {}
