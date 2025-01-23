import 'package:either_dart/either.dart';
import 'package:food_safety/core/domain/services/permission_handler_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:q_architecture/q_architecture.dart';

final initializeScannerUseCaseProvider = Provider(
  (ref) => InitializeScanner(
    ref.watch(permissionHandlerServiceProvider),
  ),
);

class InitializeScanner {
  final PermissionHandlerService _permissionHandlerService;

  InitializeScanner(this._permissionHandlerService);

  EitherFailureOr<void> call() async {
    final result = await _permissionHandlerService.requestPermission(
      permission: Permission.camera,
    );
    return result.fold(
      (failure) => Left(failure),
      (permissionGranted) => Right(permissionGranted),
    );
  }
}
