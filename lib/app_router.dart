import 'package:blog/app.dart';
import 'package:blog/features/auth/presentation/pages/sign_in_page.dart';
import 'package:blog/features/auth/presentation/pages/sign_up_page.dart';
import 'package:blog/features/blog/presenation/pages/blog_page.dart';
import 'package:go_router/go_router.dart';

enum AppRouter {
  home,
  blog,
  signIn,
  signUp,
}

final goRoute = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: false,
  routes: [
    GoRoute(
        path: '/',
        name: AppRouter.home.name,
        builder: (context, state) => const App(),
        routes: [
          GoRoute(
            path: 'blogs',
            name: AppRouter.blog.name,
            builder: (context, state) => const BlogPage(),
          ),
          GoRoute(
            path: 'sign-in',
            name: AppRouter.signIn.name,
            builder: (context, state) => const SignInPage(),
          ),
          GoRoute(
            path: 'sign-up',
            name: AppRouter.signUp.name,
            builder: (context, state) => const SignUpPage(),
          ),
        ]),
  ],
);
