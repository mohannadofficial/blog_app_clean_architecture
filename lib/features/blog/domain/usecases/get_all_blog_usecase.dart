import 'package:blog/core/error/failure.dart';
import 'package:blog/core/usecase/base_usecase.dart';
import 'package:blog/features/blog/domain/entities/blog.dart';
import 'package:blog/features/blog/domain/repository/base_blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetAllBlogUsecase implements BaseUsecase<List<Blog>, NoParams> {
  final BaseBlogRepository blogRepository;
  GetAllBlogUsecase({required this.blogRepository});
  @override
  Future<Either<Failure, List<Blog>>> call(NoParams params) async {
    return await blogRepository.getAllBlog();
  }
}
