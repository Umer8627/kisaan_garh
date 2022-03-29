part of 'post_cubit.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

class PostLoading extends PostState {}

class PostLoaded extends PostState {
  final List<SellerPostModel> postModel;
  PostLoaded({required this.postModel});
  @override
  List<Object> get props => [postModel];
}

class PostError extends PostState {
  final String error;
  PostError({required this.error});
  @override
  List<Object> get props => [error];
}
