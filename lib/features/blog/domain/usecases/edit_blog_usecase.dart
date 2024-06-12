import 'dart:io';

import 'package:blog/core/error/failure.dart';
import 'package:blog/core/usecase/base_usecase.dart';
import 'package:blog/features/blog/domain/entities/blog.dart';
import 'package:blog/features/blog/domain/repository/base_blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class EditBlogUsecase implements BaseUsecase<Blog, EditBlogParams> {
  final BaseBlogRepository blogRepository;

  EditBlogUsecase({required this.blogRepository});

  @override
  Future<Either<Failure, Blog>> call(EditBlogParams params) async {
    return await blogRepository.editBlog(
      id: params.id,
      title: params.title,
      image: params.image,
      imageUrl: params.imageUrl,
      content: params.content,
      posterId: params.posterId,
      topics: params.topics,
    );
  }
}

class EditBlogParams {
  final String id;
  final String title;
  final String content;
  final String posterId;
  final File? image;
  final String? imageUrl;
  final List<String> topics;
  EditBlogParams({
    required this.id,
    required this.title,
    required this.content,
    required this.posterId,
    this.image,
    this.imageUrl,
    required this.topics,
  });
}
