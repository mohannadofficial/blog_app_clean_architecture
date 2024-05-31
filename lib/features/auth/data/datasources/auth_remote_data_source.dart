import 'package:blog/core/error/exception.dart';
import 'package:blog/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BaseAuthRemoteDataSource {
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<UserModel> signInWithEmailPassword({
    required String email,
    required String password,
  });
  Session? get currentUserSession;
  Future<UserModel?> getCurrentUser();
}

class AuthRemoteDataSource implements BaseAuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSource({required this.supabaseClient});

  @override
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(
        email: email,
        password: password,
        data: {
          'name': name,
        },
      );

      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<UserModel> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      if (currentUserSession != null) {
        final user = await supabaseClient.from('profiles').select().eq(
              "id",
              currentUserSession!.user.id,
            );

        return UserModel.fromJson(user.first);
      }
      return null;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
