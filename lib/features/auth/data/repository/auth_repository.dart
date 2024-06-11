import 'package:blog/core/constants/constants.dart';
import 'package:blog/core/error/exception.dart';
import 'package:blog/core/error/failure.dart';
import 'package:blog/core/network/connection_checker.dart';
import 'package:blog/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog/features/auth/data/models/user_model.dart';
import 'package:blog/features/auth/domain/entities/user.dart';
import 'package:blog/features/auth/domain/repository/base_auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepository implements BaseAuthRepository {
  final BaseAuthRemoteDataSource authRemoteDataSource;
  final BaseConnectionChecker connectionChecker;
  AuthRepository(
      {required this.authRemoteDataSource, required this.connectionChecker});

  @override
  Future<Either<Failure, UserModel>> signUpWithEmailPasswrod({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(Failure(
          message: Constants.noConnectionErrorMessage,
        ));
      }
      final user = await authRemoteDataSource.signUpWithEmailPassword(
        email: email,
        name: name,
        password: password,
      );

      return right(user);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, UserModel>> signInWithEmailPasswrod({
    required String email,
    required String password,
  }) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(
          Failure(
            message: Constants.noConnectionErrorMessage,
          ),
        );
      }
      final user = await authRemoteDataSource.signInWithEmailPassword(
        email: email,
        password: password,
      );

      return right(user);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      if (!await (connectionChecker.isConnected)) {
        final session = authRemoteDataSource.currentUserSession;
        if (session == null) {
          return Left(Failure(message: Constants.nUserNotLoggedIn));
        }

        return right(
          UserModel(
            id: session.user.id,
            email: session.user.email ?? '',
            name: '',
          ),
        );
      }
      final user = await authRemoteDataSource.getCurrentUser();
      if (user == null) {
        return left(Failure(message: Constants.nUserNotLoggedIn));
      }
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }
}
