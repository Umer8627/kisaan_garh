import 'package:kisaan_garh/global_variable/global_varialble.dart';
import 'package:kisaan_garh/models/post_model/buyer_post_model.dart';
import 'package:kisaan_garh/models/post_model/seller_post_model.dart';

class BuyerRepository {
  Stream<List<BuyerPostModel>> getAllPost() {
    return firebaseFirestore.collection("buyer_post").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => BuyerPostModel.fromSnap(doc)).toList();
    });
  }
}
