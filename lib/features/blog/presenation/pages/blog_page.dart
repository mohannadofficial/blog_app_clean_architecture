import 'package:blog/app_router.dart';
import 'package:blog/core/common/cubit/app_user_cubit.dart';
import 'package:blog/core/common/widgets/loader.dart';
import 'package:blog/core/theme/app_pallete.dart';
import 'package:blog/core/utils/show_snackbar.dart';
import 'package:blog/features/blog/presenation/bloc/blog_bloc.dart';
import 'package:blog/features/blog/presenation/widgets/blog_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  void deleteBlog({required BuildContext context, required String id}) {
    context.read<BlogBloc>().add(
          DeleteBlogEvent(
            id: id,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final userId =
        (context.read<AppUserCubit>().state as AppUserLoggedIn).user.id;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog App'),
        actions: [
          IconButton(
            onPressed: () => context.pushNamed(AppRouter.addBlog.name),
            icon: const Icon(CupertinoIcons.add_circled),
          ),
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state.submissionStatus == SubmissionStatus.error) {
            showSnackBar(context: context, text: state.error);
          }
        },
        builder: (context, state) {
          if (state.submissionStatus == SubmissionStatus.inProgress) {
            return const Loader();
          }

          if (state.submissionStatus == SubmissionStatus.loaded) {
            return ListView.builder(
              itemCount: state.blogs.length,
              itemBuilder: (context, index) {
                final blog = state.blogs[index];

                return BlogCard(
                  blog: blog,
                  isOwn: blog.posterId == userId,
                  function: () => deleteBlog(context: context, id: blog.id),
                  color: index % 2 == 0
                      ? AppPallete.gradient1
                      : AppPallete.gradient2,
                );
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
