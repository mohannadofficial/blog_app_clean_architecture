import 'package:blog/core/common/cubit/app_user_cubit.dart';
import 'package:blog/features/auth/presentation/pages/sign_in_page.dart';
import 'package:blog/features/blog/presenation/pages/blog_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AppUserCubit, AppUserState, bool>(
      selector: (state) {
        return state is AppUserLoggedIn;
      },
      builder: (context, isLoggedIn) {
        return isLoggedIn ? const BlogPage() : const SignInPage();
      },
    );
  }
}
