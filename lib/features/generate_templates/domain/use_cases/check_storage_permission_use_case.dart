

import 'dart:io' show Platform;

import 'package:device_info_plus/device_info_plus.dart' show DeviceInfoPlugin;
import 'package:id_card_front_end/core/base/base_use_case/use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart' ;

@lazySingleton
class CheckStoragePermissionUseCase extends UseCase<bool, bool> {

  const CheckStoragePermissionUseCase();

  @override
  Future<bool?> call({required bool params}) async {
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      final sdkInt = androidInfo.version.sdkInt;

      if (sdkInt < 33) {
        final status = await Permission.storage.request();
        return status.isGranted;
      }
    }
    else if(Platform.isIOS){
      final status = await Permission.photos.request();
      return status.isGranted;
    }
    else if(Platform.isMacOS){
      final status = await Permission.photos.request();
      return status.isGranted;
    }
    else if(Platform.isWindows){
      return true;
    }
    else if(Platform.isLinux){
      return true;
    }
    else {
      return true;
    }
    return null;
  }

}