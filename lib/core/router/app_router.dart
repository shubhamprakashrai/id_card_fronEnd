import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:id_card_front_end/core/auth_global_cubit/auth_cubit.dart';
import 'package:id_card_front_end/core/di/service_locator.dart';
import 'package:id_card_front_end/features/login/presentation/page/sign_in_view.dart';
import 'package:id_card_front_end/features/signup/presentation/page/registration_page_view.dart';
import 'package:id_card_front_end/features/templete/presentation/page/templete_view.dart';
class AppRouter {
  static final GoRouter router=GoRouter(
    initialLocation: '/registration',
    refreshListenable: GoRouterRefreshStream(sl<AuthCubit>().stream),
    redirect: (context, state) {
      final authStatus=sl<AuthCubit>().state;
       final isLoggingIn = state.uri.path == '/lgingPage' || state.uri.path == '/registration';
      if (authStatus == AuthStatus.unKnown) return null;
      if (authStatus == AuthStatus.unAuthenticated && !isLoggingIn) {
        return '/lgingPage';
      }
      if (authStatus == AuthStatus.authenticated && isLoggingIn) {
        return '/templeteView';
      }
      return null;
    },
    routes: [
    GoRoute(
      path: '/registration',
     builder: (context, state) => RegistrationPageView(),
    ),
    GoRoute(path: '/lgingPage',builder: (context, state) => SignInView(),),
    GoRoute(path: '/templeteView',builder: (context, state) => TempleteView(),),
   ]
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
