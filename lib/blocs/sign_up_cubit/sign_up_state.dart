part of 'sign_up_cubit.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

class SignUpInitial extends SignUpState {}

class SignUpSuccess extends SignUpState {
  final User? user;
  SignUpSuccess({this.user});
}

class SignUpFailed extends SignUpState {
  final String error;
  SignUpFailed({required this.error});
  @override
  List<Object> get props => [error];
}
