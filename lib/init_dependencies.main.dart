part of 'init_dependencies.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  await Hive.initFlutter();

  final supabase = await Supabase.initialize(
    url: AppSecret.supabaseUrl,
    anonKey: AppSecret.supabaseAnonKey,
  );

  final box = await Hive.openBox('blogs');

  // SupaBase
  sl.registerLazySingleton<SupabaseClient>(
    () => supabase.client,
  );

  // packages
  sl.registerLazySingleton<InternetConnection>(
    () => InternetConnection(),
  );

  sl.registerLazySingleton<Box>(
    () => box,
  );

  // core
  sl.registerLazySingleton<AppUserCubit>(() => AppUserCubit());

  sl.registerLazySingleton<BaseConnectionChecker>(
    () => ConnectionChecker(
      internetConnection: sl(),
    ),
  );

  _initAuth();
  _initBlog();
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
        connectionChecker: sl(),
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
    )
    ..registerLazySingleton<GetCurrentUserUsecase>(
      () => GetCurrentUserUsecase(
        authRepository: sl(),
      ),
    );
}

void _initBlog() {
  sl
    // DataSource
    ..registerLazySingleton<BaseBlogRemoteDataSource>(
      () => BlogRemoteDataSource(
        supabaseClient: sl(),
      ),
    )
    ..registerLazySingleton<BaseBlogLocalDataSource>(
      () => BlogLocalDataSource(
        box: sl(),
      ),
    )

    //Repository
    ..registerLazySingleton<BaseBlogRepository>(
      () => BlogRepository(
        blogRemoteDataSource: sl(),
        connectionChecker: sl(),
        blogLocalDataSource: sl(),
      ),
    )
    //UseCases
    ..registerLazySingleton<AddNewBlogUsecase>(
      () => AddNewBlogUsecase(
        blogRepository: sl(),
      ),
    )
    ..registerLazySingleton<GetAllBlogUsecase>(
      () => GetAllBlogUsecase(
        blogRepository: sl(),
      ),
    )
    ..registerLazySingleton<EditBlogUsecase>(
      () => EditBlogUsecase(
        blogRepository: sl(),
      ),
    )
    ..registerLazySingleton<DeleteBlogUsecase>(
      () => DeleteBlogUsecase(
        blogRepository: sl(),
      ),
    );
}
