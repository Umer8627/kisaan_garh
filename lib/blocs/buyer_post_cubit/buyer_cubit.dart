import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:kisaan_garh/respository/post_repo/buyer_post_repo.dart';



import '../seller_post_cubit/post_cubit.dart';
import 'buyer_cubit_states.dart';

class BuyerPostCubit extends Cubit<BuyerPost> {
  final BuyerRepository postRepository;
  BuyerPostCubit({required this.postRepository}) : super(BuyerPostLoading());

  StreamSubscription? _postSubcription;

  void loadPost() async {
    try {
      _postSubcription?.cancel();
      _postSubcription = postRepository.getAllPost().listen((postsList) {
        emit(BuyerPostLoaded(postModel: postsList));
      });
    } catch (e) {
      emit(BuyerPostError(error: e.toString()));
    }
  }
}
