import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:id_card_front_end/core/auth_global_cubit/auth_cubit.dart';
import 'package:id_card_front_end/core/di/service_locator.dart';
import 'package:id_card_front_end/features/login/presentation/page/sign_in_view.dart';
import 'package:id_card_front_end/features/signup/presentation/page/registration_page_view.dart';
import 'package:id_card_front_end/features/splash/presentation/pages/splash_view.dart';
import 'package:id_card_front_end/features/templete/presentation/page/templete_view.dart';

import 'route_names.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: RouteName.splash,
    routes: [
      GoRoute(
        path: RouteName.splash,
        name: RouteName.splash,
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: RouteName.registration,
        name: RouteName.registration,
        builder: (context, state) => const RegistrationPageView(),
      ),
      GoRoute(
        path: RouteName.login,
        name: RouteName.login,
        builder: (context, state) => const SignInView(),
      ),
      GoRoute(
        path: RouteName.template,
        name: RouteName.template,
        builder: (context, state) => const TempleteView(),
      ),
    ],
  );
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) {
      notifyListeners();
    });
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
