import 'package:blog/features/auth/domain/entities/user.dart';
import 'package:blog/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:blog/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpUsecase _signUp;
  final SignInUsecase _signIn;

  AuthBloc({
    required SignUpUsecase signUp,
    required SignInUsecase signIn,
  })  : _signUp = signUp,
        _signIn = signIn,
        super(AuthInitial()) {
    on<SignUpEvent>(_signUpWithEmailPassword);
    on<SignInEvent>(_signInWithEmailPassword);
  }

  void _signUpWithEmailPassword(
    SignUpEvent event,
    Emitter<AuthState> emit,
  ) async {
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
      (r) => emit(AuthSuccess(user: r)),
    );
  }

  void _signInWithEmailPassword(
      SignInEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final res = await _signIn(
      SignInParams(
        email: event.email,
        password: event.password,
      ),
    );

    res.fold(
      (l) => emit(
        AuthFailure(l.message),
      ),
      (r) => emit(AuthSuccess(user: r)),
    );
  }
}
