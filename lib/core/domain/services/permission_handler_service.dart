import 'package:food_safety/core/data/services/permission_handler_service_impl.dart';
import 'package:food_safety/core/data/wrappers/permission_handler_wrapper.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:q_architecture/q_architecture.dart';

final permissionHandlerServiceProvider = Provider<PermissionHandlerService>(
  (ref) => PermissionHandlerServiceImpl(
    PermissionHandlerWrapper(),
  ),
);

abstract class PermissionHandlerService {
  EitherFailureOr<void> requestPermission({
    required Permission permission,
  });
}
