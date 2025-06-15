import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:id_card_front_end/features/data_scrapper/presentation/pages/import_excel_page.dart' show ImportExcelPage;
import 'package:id_card_front_end/features/login/presentation/page/sign_in_view.dart';
import 'package:id_card_front_end/features/signup/presentation/page/registration_page_view.dart';
import 'package:id_card_front_end/features/splash/presentation/pages/splash_view.dart';
import 'package:id_card_front_end/features/templete/presentation/page/templete_view.dart';
import 'package:id_card_front_end/features/templete/presentation/widget/form_page.dart';

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
        builder: (context, state) => const TemplateView(),
      ),
      GoRoute(
        path: RouteName.formView,
        name: RouteName.formView,
        builder: (context, state) => FormPage(index: state.extra as int,),
      ),

      GoRoute(
        path: RouteName.importExcelPage,
        name: RouteName.importExcelPage,
        builder: (context, state) => ImportExcelPage(),
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
