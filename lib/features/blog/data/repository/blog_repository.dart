import 'dart:io';

import 'package:blog/core/constants/constants.dart';
import 'package:blog/core/error/exception.dart';
import 'package:blog/core/error/failure.dart';
import 'package:blog/core/network/connection_checker.dart';
import 'package:blog/features/blog/data/datasources/blog_local_data_source.dart';
import 'package:blog/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:blog/features/blog/data/models/blog_model.dart';
import 'package:blog/features/blog/domain/entities/blog.dart';
import 'package:blog/features/blog/domain/repository/base_blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class BlogRepository implements BaseBlogRepository {
  final BaseBlogLocalDataSource blogLocalDataSource;
  final BaseConnectionChecker connectionChecker;
  final BaseBlogRemoteDataSource blogRemoteDataSource;
  BlogRepository({
    required this.blogRemoteDataSource,
    required this.connectionChecker,
    required this.blogLocalDataSource,
  });

  @override
  Future<Either<Failure, Blog>> addNewBlog(
      {required String title,
      required String content,
      required String posterId,
      required File image,
      required List<String> topics}) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(
          Failure(
            message: Constants.noConnectionErrorMessage,
          ),
        );
      }
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

  @override
  Future<Either<Failure, List<Blog>>> getAllBlog() async {
    try {
      if (!await (connectionChecker.isConnected)) {
        final blogs = blogLocalDataSource.loadBlogs();
        return right(blogs);
      }
      final blogs = await blogRemoteDataSource.getAllBlog();
      blogLocalDataSource.uploadBlogs(blogs);
      return right(blogs);
    } on ServerException catch (e) {
      return Left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Blog>> editBlog({
    required String id,
    required String title,
    required String content,
    required String posterId,
    File? image,
    String? imageUrl,
    required List<String> topics,
  }) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(
          Failure(message: Constants.noConnectionErrorMessage),
        );
      }

      BlogModel blogModel = BlogModel(
        id: id,
        content: content,
        imageUrl: imageUrl ?? '',
        posterId: posterId,
        title: title,
        topics: topics,
        posterName: posterId,
        updatedAt: DateTime.now(),
      );

      if (imageUrl == null && image != null) {
        final imageUrlNew = await blogRemoteDataSource.uploadBlogImage(
          blog: blogModel,
          image: image,
        );

        blogModel = blogModel.copyWith(imageUrl: imageUrlNew);
      }
      final blogData = await blogRemoteDataSource.editBlog(blog: blogModel);

      return right(blogData);
    } on ServerException catch (e) {
      return left(
        Failure(message: e.message),
      );
    }
  }

  @override
  Future<Either<Failure, Blog>> deleteBlog({required String id}) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(
          Failure(message: Constants.noConnectionErrorMessage),
        );
      }
      final blog = await blogRemoteDataSource.deleteBlog(id: id);
      return right(blog);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }
}
