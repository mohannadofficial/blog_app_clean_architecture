import 'package:blog/core/error/failure.dart';
import 'package:blog/core/usecase/base_usecase.dart';
import 'package:blog/features/auth/domain/entities/user.dart';
import 'package:blog/features/auth/domain/repository/base_auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class SignUpUsecase implements BaseUsecase<User, SignUpParams> {
  final BaseAuthRepository authRepository;

  SignUpUsecase({required this.authRepository});

  @override
  Future<Either<Failure, User>> call(SignUpParams params) {
    return authRepository.signUpWithEmailPasswrod(
      email: params.email,
      name: params.name,
      password: params.passowrd,
    );
  }
}

class SignUpParams {
  final String name;
  final String passowrd;
  final String email;
  SignUpParams({
    required this.name,
    required this.passowrd,
    required this.email,
  });
}
