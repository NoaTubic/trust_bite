import 'package:either_dart/either.dart';
import 'package:food_safety/core/data/wrappers/permission_handler_wrapper.dart';
import 'package:food_safety/core/domain/failures/permission_failure.dart';
import 'package:food_safety/core/domain/services/permission_handler_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:q_architecture/q_architecture.dart';

class PermissionHandlerServiceImpl implements PermissionHandlerService {
  final PermissionHandlerWrapper _permissionHandlerWrapper;

  PermissionHandlerServiceImpl(
    this._permissionHandlerWrapper,
  );

  @override
  EitherFailureOr<void> requestPermission({
    required Permission permission,
  }) async {
    final status =
        await _permissionHandlerWrapper.getPermissionStatus(permission);
    if (status.isGranted) {
      return const Right(null);
    } else {
      return Left(
        PermissionFailure(
          permission: permission,
        ),
      );
    }
  }
}
