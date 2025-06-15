import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:id_card_front_end/core/auth_global_cubit/auth_cubit.dart';
import 'package:id_card_front_end/core/di/service_locator.dart';
import 'package:id_card_front_end/features/login/presentation/page/sign_in_view.dart';
import 'package:id_card_front_end/features/signup/presentation/page/registration_page_view.dart';
import 'package:id_card_front_end/features/templete/presentation/page/templete_view.dart';

import 'route_names.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: RouteName.login,
    refreshListenable: GoRouterRefreshStream(sl<AuthCubit>().stream),
    redirect: (context, state) {
      final authStatus = sl<AuthCubit>().state;
      final isLoggingIn = state.uri.path == RouteName.login ||
          state.uri.path == RouteName.registration;

      if (authStatus == AuthStatus.unKnown) return null;
      if (authStatus == AuthStatus.unAuthenticated && !isLoggingIn) {
        return RouteName.login;
      }
      if (authStatus == AuthStatus.authenticated && isLoggingIn) {
        return RouteName.template;
      }
      return null;
    },
    routes: [
      GoRoute(
        path: RouteName.registration,
        builder: (context, state) => const RegistrationPageView(),
      ),
      GoRoute(
        path: RouteName.login,
        builder: (context, state) => const SignInView(),
      ),
      GoRoute(
        path: RouteName.template,
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
