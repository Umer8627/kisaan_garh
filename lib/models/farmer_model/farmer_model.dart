import 'package:cloud_firestore/cloud_firestore.dart';

class FarmerModel {
  String docId;
  String address;
  String type;
  FarmerModel({required this.docId, required this.address,required this.type});
  Map<String, dynamic> toJson() => {
        "docId": docId,
        "address": address,
        "type":type,
      };

  static FarmerModel fromSnap(DocumentSnapshot snapshot) {
    var snapdata = snapshot.data() as Map<String, dynamic>;
    return FarmerModel(docId: snapdata["docId"], address: snapdata["address"],type: snapdata["type"]);
  }
}
