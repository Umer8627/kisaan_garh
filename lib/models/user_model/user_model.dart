import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id;
  String name;
  String email;
  String password;
  String cnic;
  String number;

  UserModel(
      {required this.id,
      required this.name,
      required this.cnic,
      required this.email,
      required this.number,
      required this.password});
  Map<String, dynamic> toJson() => {
        "docId": id,
        "name": name,
        "number": number,
        "cnic": cnic,
        "email": email,
        "password": password,
      };

  static UserModel fromSnap(DocumentSnapshot snapshot) {
    var snapdata = snapshot.data() as Map<String, dynamic>;

    return UserModel(
      id: snapdata['docId'],
      name: snapdata["name"],
      cnic: snapdata['cnic'],
      email: snapdata['email'],
      number: snapdata['number'],
      password: snapdata['password'],
    );
  }
}
