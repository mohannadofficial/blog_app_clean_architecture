import 'dart:io';

import 'package:blog/core/error/failure.dart';
import 'package:blog/features/blog/domain/entities/blog.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class BaseBlogRepository {
  Future<Either<Failure, Blog>> addNewBlog({
    required String title,
    required String content,
    required String posterId,
    required File image,
    required List<String> topics,
  });

  Future<Either<Failure, List<Blog>>> getAllBlog();
  Future<Either<Failure, Blog>> editBlog({
    required String id,
    required String title,
    required String content,
    required String posterId,
    File? image,
    String? imageUrl,
    required List<String> topics,
  });
  Future<Either<Failure, Blog>> deleteBlog({required String id});
}
