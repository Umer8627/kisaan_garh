
import 'package:cloud_firestore/cloud_firestore.dart';

class BuyerPostModel{
  String uid;
  String docId;
  String username;
  final publishedDate;
  String productName;
  String quantity;
  String description;
  String averagePrice;
  String userType;
  String postType;
  BuyerPostModel({
    required this.productName,
    required this.description,
    required this.averagePrice,
    required this.quantity,
    required this.uid,
    required this.username,
    required this.docId,
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
    "productDescription": description,
    "productPrice": averagePrice,
    "quantity":quantity,
    "userType": userType,
    "postType":postType,
  };
  static BuyerPostModel fromSnap(DocumentSnapshot snapshot){
    var snap = snapshot.data() as Map<String,dynamic>;
    return BuyerPostModel(
      postType: snap["postType"],
      productName: snap["productName"], description: snap["productDescription"],
        averagePrice: snap["productPrice"], quantity: snap["quantity"], uid: snap["uid"], userType: snap["userType"],
      docId: snap["docId"],
      username: snap["username"], publishedDate: snap["publishedDate"],);
  }
}