import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String fullName;
  final String emailAddress;
  final String password;
  final String contactNumber;
  final String userUid;

  UserModel({
    required this.fullName,
    required this.emailAddress,
    required this.password,
    required this.contactNumber,
    required this.userUid,
  });

  factory UserModel.fromDocument(DocumentSnapshot doc) {
    return UserModel(
      fullName: doc['FullName'],
      emailAddress: doc['emailAddress'],
      password: doc['Passsword'],
      contactNumber: doc['Contact'],
      userUid: doc['UserUid'],
    );
  }
}
