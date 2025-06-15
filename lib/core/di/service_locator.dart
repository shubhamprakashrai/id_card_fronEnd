import 'package:get_it/get_it.dart';
import 'package:id_card_front_end/core/di/service_locator.config.dart' show inject;
import 'package:injectable/injectable.dart';

final GetIt sl = GetIt.instance;

@InjectableInit(
    initializerName: 'inject',
    preferRelativeImports: true,
    asExtension: false
)
void configureDependencies() => inject(sl);
