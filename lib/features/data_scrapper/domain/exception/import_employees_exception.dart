
import 'package:id_card_front_end/features/data_scrapper/domain/exception/data_scrapper_exception.dart' show DataScrapperException;

class ImportEmployeesException extends DataScrapperException {

  final StackTrace? stackTrace;

  const ImportEmployeesException({
    this.stackTrace,
    super.message = 'Failed to import employees from Excel file.',
    super. code = 1001,
  });

  @override
  String toString() => 'ImportEmployeesException: $message (Code: $code)';
}