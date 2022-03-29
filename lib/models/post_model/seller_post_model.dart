import 'package:cloud_firestore/cloud_firestore.dart';

class SellerPostModel {
  String uid;
  String docId;
  String username;
  final publishedDate;
  String productName;
  String productDescription;
  String price;
  String productImage;
  String userType;
  String postType;
  SellerPostModel(
      {required this.productImage,
      required this.uid,
      required this.docId,
      required this.username,
      required this.price,
      required this.productDescription,
      required this.productName,
      this.publishedDate,
      required this.userType,
        required this.postType,
      });

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "docId": docId,
        "username": username,
        "publishedDate": publishedDate,
        "productName": productName,
        "productDescription": productDescription,
        "productPrice": price,
        "productImage": productImage,
         "userType": userType,
         "postType":postType,
      };
  static SellerPostModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return SellerPostModel(
      postType: snapshot["postType"],
      userType: snapshot["userType"],
      docId: snapshot["docId"],
      uid: snapshot["uid"],
      username: snapshot["username"],
      price: snapshot["productPrice"],
      productDescription: snapshot["productDescription"],
      productImage: snapshot["productImage"],
      productName: snapshot["productName"],
      publishedDate: snapshot["publishedDate"],
    );
  }
}
