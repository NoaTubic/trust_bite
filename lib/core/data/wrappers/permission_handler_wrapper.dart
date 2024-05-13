import 'package:permission_handler/permission_handler.dart';

class PermissionHandlerWrapper {
  Future<PermissionStatus> getPermissionStatus(Permission permission) async =>
      permission.request();
}
