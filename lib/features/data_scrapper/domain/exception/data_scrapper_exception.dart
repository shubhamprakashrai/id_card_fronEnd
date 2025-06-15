import 'package:id_card_front_end/core/base/base_exception/base_exception.dart';

class DataScrapperException extends BaseException {
  const DataScrapperException({
    required super.message,
    required super.code,
  });
}