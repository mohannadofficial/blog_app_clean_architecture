import 'package:blog/core/common/cubit/app_user_cubit.dart';
import 'package:blog/core/usecase/base_usecase.dart';
import 'package:blog/features/auth/domain/entities/user.dart';
import 'package:blog/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:blog/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:blog/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AppUserCubit _appUserCubit;

  final SignUpUsecase _signUp;
  final SignInUsecase _signIn;
  final GetCurrentUserUsecase _getCurrentUser;

  AuthBloc({
    required SignUpUsecase signUp,
    required SignInUsecase signIn,
    required GetCurrentUserUsecase getCurrentUser,
    required AppUserCubit appUserCubit,
  })  : _signUp = signUp,
        _signIn = signIn,
        _getCurrentUser = getCurrentUser,
        _appUserCubit = appUserCubit,
        super(AuthInitial()) {
    on<AuthEvent>(
      (_, emit) => emit(AuthLoading()),
    );
    on<SignUpEvent>(_signUpWithEmailPassword);
    on<SignInEvent>(_signInWithEmailPassword);
    on<GetCurrentUserEvent>(_getCurrentLoggedUser);
  }

  void _signUpWithEmailPassword(
    SignUpEvent event,
    Emitter<AuthState> emit,
  ) async {
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
      (r) => _emitAuthSuccess(user: r, emit: emit),
    );
  }

  void _signInWithEmailPassword(
      SignInEvent event, Emitter<AuthState> emit) async {
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
      (r) => _emitAuthSuccess(user: r, emit: emit),
    );
  }

  void _getCurrentLoggedUser(
      GetCurrentUserEvent event, Emitter<AuthState> emit) async {
    final res = await _getCurrentUser(NoParams());
    res.fold(
      (l) => emit(AuthFailure(l.message)),
      (r) => _emitAuthSuccess(user: r, emit: emit),
    );
  }

  void _emitAuthSuccess(
      {required User user, required Emitter<AuthState> emit}) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user: user));
  }
}
