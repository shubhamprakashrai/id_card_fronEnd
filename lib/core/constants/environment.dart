enum Environment { local, staging, production }

class AppEnvironment {
  static const Environment current = Environment.local; // change this manually
}
