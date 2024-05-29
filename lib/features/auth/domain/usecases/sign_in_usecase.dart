import 'package:blog/core/error/failure.dart';
import 'package:blog/core/usecase/base_usecase.dart';
import 'package:blog/features/auth/domain/entities/user.dart';
import 'package:blog/features/auth/domain/repository/base_auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class SignInUsecase implements BaseUsecase<User, SignInParams> {
  final BaseAuthRepository authRepository;
  SignInUsecase({required this.authRepository});
  @override
  Future<Either<Failure, User>> call(SignInParams params) async {
    return await authRepository.signInWithEmailPasswrod(
      email: params.email,
      password: params.password,
    );
  }
}

class SignInParams {
  final String email;
  final String password;
  SignInParams({
    required this.email,
    required this.password,
  });
}
