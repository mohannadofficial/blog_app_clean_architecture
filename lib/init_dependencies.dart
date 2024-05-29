import 'package:blog/core/secrets/app_secrets.dart';
import 'package:blog/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog/features/auth/data/repository/auth_repository.dart';
import 'package:blog/features/auth/domain/repository/base_auth_repository.dart';
import 'package:blog/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:blog/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );

  // SupaBase
  sl.registerLazySingleton<SupabaseClient>(
    () => supabase.client,
  );
}

void _initAuth() {
  sl
    // DataSource
    ..registerLazySingleton<BaseAuthRemoteDataSource>(
      () => AuthRemoteDataSource(
        supabaseClient: sl(),
      ),
    )
    // Repostiroy
    ..registerLazySingleton<BaseAuthRepository>(
      () => AuthRepository(
        authRemoteDataSource: sl(),
      ),
    )
    // UseCase
    ..registerLazySingleton<SignUpUsecase>(
      () => SignUpUsecase(
        authRepository: sl(),
      ),
    )
    ..registerLazySingleton<SignInUsecase>(
      () => SignInUsecase(
        authRepository: sl(),
      ),
    );
}
