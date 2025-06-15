import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart' show Logger;

class AppBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    Logger().d('$event');
    super.onEvent(bloc, event);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    Logger().d('$stackTrace');
    super.onError(bloc, error, stackTrace);
  }
}
