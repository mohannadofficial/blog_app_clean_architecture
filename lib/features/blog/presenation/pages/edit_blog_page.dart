import 'package:blog/features/blog/presenation/bloc/blog_bloc.dart';
import 'package:blog/features/blog/presenation/widgets/blog_details.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditBlogPage extends StatelessWidget {
  final String id;
  const EditBlogPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final blog = context.read<BlogBloc>().state.blogs.firstWhere(
          (element) => element.id == id,
        );
    return BlogDetails(
      blog: blog,
    );
  }
}
