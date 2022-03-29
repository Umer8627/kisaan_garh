import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kisaan_garh/models/post_model/seller_post_model.dart';
import 'package:kisaan_garh/respository/post_repo/seller_post_repo.dart';

part 'post_state.dart';

class SellerPostCubit extends Cubit<PostState> {
  final SellerRepository postRepository;
  SellerPostCubit({required this.postRepository}) : super(PostLoading());

  StreamSubscription? _postSubcription;

  void loadPost() async {
    try {
      _postSubcription?.cancel();
      _postSubcription = postRepository.getAllPost().listen((postsList) {
        emit(PostLoaded(postModel: postsList));
      });
    } catch (e) {
      emit(PostError(error: e.toString()));
    }
  }
}
