import 'package:blog/core/error/failure.dart';
import 'package:blog/core/usecase/base_usecase.dart';
import 'package:blog/features/auth/domain/entities/user.dart';
import 'package:blog/features/auth/domain/repository/base_auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetCurrentUserUsecase implements BaseUsecase<User, NoParams> {
  final BaseAuthRepository authRepository;
  GetCurrentUserUsecase({required this.authRepository});
  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await authRepository.getCurrentUser();
  }
}
