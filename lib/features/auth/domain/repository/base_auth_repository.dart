import 'package:blog/core/error/failure.dart';
import 'package:blog/features/auth/domain/entities/user.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class BaseAuthRepository {
  Future<Either<Failure, User>> signUpWithEmailPasswrod({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> signInWithEmailPasswrod({
    required String email,
    required String password,
  });
}
