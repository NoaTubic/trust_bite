import 'package:permission_handler/permission_handler.dart';
import 'package:q_architecture/q_architecture.dart';

abstract class PermissionHandlerService {
  EitherFailureOr<void> requestPermission({
    required Permission permission,
  });
}
