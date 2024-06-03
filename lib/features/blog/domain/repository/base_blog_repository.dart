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
}
