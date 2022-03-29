

import 'package:equatable/equatable.dart';
import 'package:kisaan_garh/models/post_model/buyer_post_model.dart';

abstract class BuyerPost extends Equatable {
  const BuyerPost();

  @override
  List<Object> get props => [];
}

class BuyerPostLoading extends BuyerPost {}

class BuyerPostLoaded extends BuyerPost {
  final List<BuyerPostModel> postModel;
  BuyerPostLoaded({required this.postModel});
  @override
  List<Object> get props => [postModel];
}

class BuyerPostError extends BuyerPost {
  final String error;
  BuyerPostError({required this.error});
  @override
  List<Object> get props => [error];
}
