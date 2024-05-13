import 'package:permission_handler/permission_handler.dart';
import 'package:q_architecture/q_architecture.dart';

class PermissionFailure extends Failure {
  final Permission permission;

  const PermissionFailure({
    required this.permission,
    super.title = '',
  });
}
