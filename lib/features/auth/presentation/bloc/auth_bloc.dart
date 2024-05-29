import 'package:blog/features/auth/domain/entities/user.dart';
import 'package:blog/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpUsecase _signUp;

  AuthBloc({required SignUpUsecase signUp})
      : _signUp = signUp,
        super(AuthInitial()) {
    on<SignUpEvent>(
      (event, emit) async {
        emit(AuthLoading());

        final res = await _signUp(
          SignUpParams(
            email: event.email,
            name: event.name,
            passowrd: event.password,
          ),
        );

        res.fold(
          (l) => emit(
            AuthFailure(l.message),
          ),
          (r) => AuthSuccess(user: r),
        );
      },
    );
  }
}
