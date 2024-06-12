import 'package:blog/app_router.dart';
import 'package:blog/core/common/cubit/app_user_cubit.dart';
import 'package:blog/core/theme/app_theme.dart';
import 'package:blog/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog/features/blog/presenation/bloc/blog_bloc.dart';
import 'package:blog/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => sl<AppUserCubit>(),
      lazy: false,
    ),
    BlocProvider(
      create: (_) => AuthBloc(
        signUp: sl(),
        signIn: sl(),
        appUserCubit: sl(),
        getCurrentUser: sl(),
      )..add(GetCurrentUserEvent()),
    ),
    BlocProvider(
      create: (context) => BlogBloc(
        addNewBlog: sl(),
        getAllBlog: sl(),
        editBlog: sl(),
        deleteBlog: sl(),
      )..add(GetAllBlogEvent()),
    )
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Blog App',
      onGenerateTitle: (context) => 'Blog App',
      theme: AppTheme.darkThemeMode,
      routerConfig: goRoute,
    );
  }
}
