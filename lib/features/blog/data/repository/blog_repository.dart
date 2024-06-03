import 'dart:io';

import 'package:blog/core/error/exception.dart';
import 'package:blog/core/error/failure.dart';
import 'package:blog/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:blog/features/blog/data/models/blog_model.dart';
import 'package:blog/features/blog/domain/entities/blog.dart';
import 'package:blog/features/blog/domain/repository/base_blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class BlogRepository implements BaseBlogRepository {
  final BaseBlogRemoteDataSource blogRemoteDataSource;
  BlogRepository({required this.blogRemoteDataSource});

  @override
  Future<Either<Failure, Blog>> addNewBlog(
      {required String title,
      required String content,
      required String posterId,
      required File image,
      required List<String> topics}) async {
    try {
      BlogModel blogModel = BlogModel(
        id: const Uuid().v1(),
        title: title,
        content: content,
        posterId: posterId,
        imageUrl: '',
        topics: topics,
        updatedAt: DateTime.now(),
      );
      final imageUrl = await blogRemoteDataSource.uploadBlogImage(
        blog: blogModel,
        image: image,
      );

      blogModel = blogModel.copyWith(imageUrl: imageUrl);

      return right(await blogRemoteDataSource.addNewBlog(blog: blogModel));
    } on ServerException catch (e) {
      return left(
        Failure(message: e.message),
      );
    }
  }
}
