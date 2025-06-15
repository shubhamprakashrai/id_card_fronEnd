

import 'package:id_card_front_end/core/base/base_exception/base_exception.dart';

class PermissionNotFoundException extends BaseException {
  const PermissionNotFoundException(): super(
    message: 'Permission not found',
    code: 404,
  );
}