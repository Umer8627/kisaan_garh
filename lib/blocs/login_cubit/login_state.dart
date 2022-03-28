part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginSuccess extends LoginState {
  final User? user;
  LoginSuccess({required this.user});
}

class LoginFailed extends LoginState {
  final String error;
  LoginFailed({required this.error});
  @override
  List<Object> get props => [error];
}
