part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginInProgress extends LoginState {}

class LoginSuccess extends LoginState {
  final UserModel? user;


  const LoginSuccess({this.user});

  @override
  List<Object?> get props => [user];
}

class LoginFailure extends LoginState {
  final String? error;

  const LoginFailure({this.error});

  @override
  List<Object?> get props => [error];

  @override
  String toString() => 'LoginFailure { error: $error }';
}

class SignUpInProgress extends LoginState {}

class LoginVerification extends LoginState {
  final String? error;

  const LoginVerification({this.error});

  @override
  List<Object?> get props => [error];

  @override
  String toString() => 'LoginVerification { error: $error }';
}

class SignUpSuccess extends LoginState {}

class SignUpFailure extends LoginState {
  final String error;

  const SignUpFailure({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'SignUpFailure { error: $error }';
}
