import 'package:cloud_firestore/cloud_firestore.dart';

class FarmerModel {
  String docId;
  String address;
  FarmerModel({required this.docId, required this.address});
  Map<String, dynamic> toJson() => {
        "docId": docId,
        "address": address,
      };

  static FarmerModel fromSnap(DocumentSnapshot snapshot) {
    var snapdata = snapshot.data() as Map<String, dynamic>;
    return FarmerModel(docId: snapdata["docId"], address: snapdata["address"]);
  }
}
