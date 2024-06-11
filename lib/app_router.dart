import 'package:blog/app.dart';
import 'package:blog/core/common/cubit/app_user_cubit.dart';
import 'package:blog/features/auth/presentation/pages/sign_in_page.dart';
import 'package:blog/features/auth/presentation/pages/sign_up_page.dart';
import 'package:blog/features/blog/presenation/pages/add_new_blog_page.dart';
import 'package:blog/features/blog/presenation/pages/blog_page.dart';
import 'package:blog/features/blog/presenation/pages/blog_viewer_page.dart';
import 'package:blog/init_dependencies.dart';
import 'package:go_router/go_router.dart';

enum AppRouter {
  home,
  blog,
  blogView,
  addBlog,
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
            routes: [
              GoRoute(
                path: 'add',
                name: AppRouter.addBlog.name,
                builder: (context, state) => const AddNewBlogPage(),
              ),
              GoRoute(
                  path: ':id',
                  name: AppRouter.blogView.name,
                  builder: (context, state) {
                    final id = state.pathParameters['id'];

                    return BlogViewerPage(
                      id: id!,
                    );
                  }),
            ],
          ),
          GoRoute(
            path: 'sign-in',
            name: AppRouter.signIn.name,
            builder: (context, state) => const SignInPage(),
            redirect: (context, state) {
              if (sl<AppUserCubit>().state is AppUserLoggedIn) return '/blogs';
              return null;
            },
          ),
          GoRoute(
            path: 'sign-up',
            name: AppRouter.signUp.name,
            builder: (context, state) => const SignUpPage(),
          ),
        ]),
  ],
);
