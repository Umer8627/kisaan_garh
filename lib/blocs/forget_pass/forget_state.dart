part of 'forget_cubit.dart';

abstract class ForgetState extends Equatable {
  const ForgetState();

  @override
  List<Object> get props => [];
}

class ForgetInitial extends ForgetState {}

class ForgetSuccess extends ForgetState {}

class ForgetFailed extends ForgetState {
  final String errorMessage;
  ForgetFailed({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
