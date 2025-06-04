import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:id_card_front_end/core/constants/environment.dart';

class EnvLoader {
  static Future<void> load() async {
    String fileName;
    switch (AppEnvironment.current) {
      case Environment.staging:
        fileName = 'lib/env/.env.staging';
        break;
      case Environment.production:
        fileName = 'lib/env/.env.production';
        break;
      case Environment.local:
        fileName = 'lib/env/.env.local';

    }

    await dotenv.load(fileName: fileName);
  }
}
