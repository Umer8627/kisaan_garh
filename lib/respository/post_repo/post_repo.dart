import 'package:kisaan_garh/global_variable/global_varialble.dart';
import 'package:kisaan_garh/models/post_model/post_model.dart';

class PostRepository {
  Stream<List<PostModel>> getAllPost() {
    return firebaseFirestore.collection("posts").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => PostModel.fromSnap(doc)).toList();
    });
  }
}
