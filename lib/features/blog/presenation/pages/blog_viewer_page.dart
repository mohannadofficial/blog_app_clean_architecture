import 'package:blog/core/common/cubit/app_user_cubit.dart';
import 'package:blog/core/theme/app_pallete.dart';
import 'package:blog/core/utils/calculate_reading_time.dart';
import 'package:blog/core/utils/format_date.dart';
import 'package:blog/features/blog/presenation/bloc/blog_bloc.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class BlogViewerPage extends StatelessWidget {
  final String id;
  const BlogViewerPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlogBloc, BlogState>(
      builder: (context, state) {
        final blog = state.blogs.firstWhere(
          (element) => element.id == id,
        );

        final posterName =
            (context.read<AppUserCubit>().state as AppUserLoggedIn).user.name;

        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              blog.title,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          body: Scrollbar(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      blog.title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'By $posterName',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '${formatDateBydMMMYYYY(blog.updatedAt)} . ${calculateReadingTime(blog.content)} min',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppPallete.greyColor,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        blog.imageUrl,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      blog.content,
                      style: const TextStyle(
                        fontSize: 16,
                        height: 2,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
