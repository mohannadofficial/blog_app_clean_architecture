import 'package:blog/core/error/failure.dart';
import 'package:blog/core/usecase/base_usecase.dart';
import 'package:blog/features/blog/domain/entities/blog.dart';
import 'package:blog/features/blog/domain/repository/base_blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class DeleteBlogUsecase implements BaseUsecase<Blog, String> {
  final BaseBlogRepository blogRepository;
  DeleteBlogUsecase({required this.blogRepository});
  @override
  Future<Either<Failure, Blog>> call(String params) async {
    return await blogRepository.deleteBlog(id: params);
  }
}
