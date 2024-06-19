import 'package:blog/app_router.dart';
import 'package:blog/core/theme/app_pallete.dart';
import 'package:blog/core/utils/calculate_reading_time.dart';
import 'package:blog/features/blog/domain/entities/blog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BlogCard extends StatelessWidget {
  final Blog blog;
  final Color color;
  final bool isOwn;
  final VoidCallback? function;
  const BlogCard({
    super.key,
    required this.blog,
    required this.color,
    this.isOwn = false,
    this.function,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pushNamed(AppRouter.blogView.name, pathParameters: {
        'id': blog.id,
      }),
      child: Container(
        height: 200,
        margin: const EdgeInsets.all(16).copyWith(
          bottom: 4,
        ),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: blog.topics
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Chip(label: Text(e)),
                      ),
                    )
                    .toList(),
              ),
            ),
            Text(
              blog.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.80,
              child: Text(
                blog.content,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
            const Spacer(),
            Row(
              children: [
                Text('${calculateReadingTime(blog.content)} min'),
                if (isOwn) ...[
                  const Spacer(),
                  IconButton(
                    icon: const Icon(
                      Icons.edit,
                      color: AppPallete.whiteColor,
                    ),
                    onPressed: () => context.pushNamed(AppRouter.editBlog.name,
                        pathParameters: {'id': blog.id}),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: AppPallete.whiteColor,
                    ),
                    onPressed: function,
                  ),
                ]
              ],
            ),
          ],
        ),
      ),
    );
  }
}
