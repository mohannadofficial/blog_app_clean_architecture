import 'package:blog/features/auth/presentation/pages/sign_in_page.dart';
import 'package:blog/features/auth/presentation/pages/sign_up_page.dart';
import 'package:go_router/go_router.dart';

enum AppRouter {
  signIn,
  signUp,
}

final goRoute = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: false,
  routes: [
    GoRoute(
      path: '/',
      name: AppRouter.signIn.name,
      builder: (context, state) => const SignInPage(),
    ),
    GoRoute(
      path: '/sign-up',
      name: AppRouter.signUp.name,
      builder: (context, state) => const SignUpPage(),
    ),
  ],
);
