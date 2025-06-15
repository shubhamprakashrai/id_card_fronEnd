
import 'package:id_card_front_end/features/data_scrapper/domain/exception/data_scrapper_exception.dart';

class SaveEmployeesException extends DataScrapperException {
  const SaveEmployeesException({
    String message = 'Failed to save employees.',
    int code = 1002,
  }) : super(message: message, code: code);

  @override
  String toString() => 'SaveEmployeesException: $message (Code: $code)';
}