
import 'package:id_card_front_end/features/data_scrapper/domain/exception/data_scrapper_exception.dart' show DataScrapperException;

class ImporterBlocException extends DataScrapperException {
  final StackTrace? stackTrace;

  const ImporterBlocException({
    String message = 'ImporterBloc encountered an error.',
    int code = 1003,
    this.stackTrace,
  }) : super(message: message, code: code);

  @override
  String toString() => 'ImporterBlocException: $message (Code: $code)${stackTrace != null ? '\n$stackTrace' : ''}';
}