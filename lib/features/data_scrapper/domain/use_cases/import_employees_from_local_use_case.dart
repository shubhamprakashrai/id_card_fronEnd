

import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:id_card_front_end/core/base/base_use_case/use_case.dart';
import 'package:injectable/injectable.dart';

@singleton
class ImportEmployeesFromLocalUseCase extends UseCase<File, int> {
  const ImportEmployeesFromLocalUseCase();
  @override
  Future<File?> call({required int params}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xls', 'xlsx'],
    );
    if (result != null && result.files.single.path != null) {
      final file = File(result.files.single.path!);
      return file;
    }
    return null;
  }
}