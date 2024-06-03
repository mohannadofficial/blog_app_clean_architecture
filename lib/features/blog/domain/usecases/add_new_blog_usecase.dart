// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:blog/core/error/failure.dart';
import 'package:blog/core/usecase/base_usecase.dart';
import 'package:blog/features/blog/domain/entities/blog.dart';
import 'package:blog/features/blog/domain/repository/base_blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class AddNewBlogUsecase implements BaseUsecase<Blog, AddNewBlogParams> {
  final BaseBlogRepository blogRepository;
  AddNewBlogUsecase({required this.blogRepository});
  @override
  Future<Either<Failure, Blog>> call(AddNewBlogParams params) async {
    return await blogRepository.addNewBlog(
      title: params.title,
      content: params.content,
      image: params.image,
      posterId: params.posterId,
      topics: params.topics,
    );
  }
}

class AddNewBlogParams {
  final String title;
  final String content;
  final String posterId;
  final File image;
  final List<String> topics;
  AddNewBlogParams({
    required this.title,
    required this.content,
    required this.posterId,
    required this.image,
    required this.topics,
  });
}
