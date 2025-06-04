import 'package:go_router/go_router.dart';
import 'package:id_card_front_end/features/login/presentation/page/sign_in_view.dart';
import 'package:id_card_front_end/features/signup/presentation/page/registration_page_view.dart';

class AppRouter {
  static final GoRouter router=GoRouter(
    initialLocation: '/registration',
    routes: [
    GoRoute(
      path: '/registration',
     builder: (context, state) => RegistrationPageView(),
    ),
    GoRoute(path: '/lgingPage',builder: (context, state) => SignInView(),),
   ]

  );
}