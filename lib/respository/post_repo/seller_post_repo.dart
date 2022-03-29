import 'package:kisaan_garh/global_variable/global_varialble.dart';
import 'package:kisaan_garh/models/post_model/seller_post_model.dart';

class SellerRepository {
  Stream<List<SellerPostModel>> getAllPost() {
    return firebaseFirestore.collection("seller_post").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => SellerPostModel.fromSnap(doc)).toList();
    });
  }
}
