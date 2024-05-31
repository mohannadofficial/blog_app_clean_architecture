part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

final class SignUpEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;

  const SignUpEvent({
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [name, email, password];
}

final class SignInEvent extends AuthEvent {
  final String email;
  final String password;

  const SignInEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

final class GetCurrentUserEvent extends AuthEvent {
  @override
  List<Object> get props => [];
}
