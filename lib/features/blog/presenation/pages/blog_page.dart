import 'package:blog/app_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: const Center(
        child: Text('Blog Page'),
      ),
    );
  }
}
