import 'package:cloud_firestore/cloud_firestore.dart';

class CompanyModel {
  String name;
  String address;

  String docId;
  CompanyModel(
      {required this.docId, required this.name, required this.address});
  Map<String, dynamic> toJson() => {
        "docId": docId,
        "company_name": name,
        "address": address,
      };

  static CompanyModel fromSnap(DocumentSnapshot snapshot) {
    var snapdata = snapshot.data() as Map<String, dynamic>;
    return CompanyModel(docId: snapdata["docId"], name: snapdata["company_name"],address: snapdata["address"]);
  }
}
