import 'package:cloud_firestore/cloud_firestore.dart';

class GymOwnerModel {
  final String id;
  String firstName;
  String lastName;
  final String userName;
  final String email;
  String phoneNumber;
  String profilePicture;
  String gymLocation;
  String gymType;
  String accountNumber;
  String bankName;

  GymOwnerModel({
    required this.id,
    this.firstName = '',
    this.lastName = '',
    required this.userName,
    required this.email,
    this.phoneNumber = '',
    this.profilePicture = '',
    this.gymLocation = '',
    this.gymType = '',
    this.accountNumber = '',
    this.bankName = '',
  });

  factory GymOwnerModel.fromJson(Map<String, dynamic> json) {
    return GymOwnerModel(
      id: json['id'],
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      userName: json['userName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'] ?? '',
      profilePicture: json['profilePicture'] ?? '',
      gymLocation: json['gymLocation'] ?? '',
      gymType: json['gymType'] ?? '',
      accountNumber: json['accountNumber'] ?? '',
      bankName: json['bankName'] ?? '',
    );
  }

  factory GymOwnerModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    if (snapshot.data() != null) {
      final data = snapshot.data()!;
      return GymOwnerModel(
        id: data['id'] ?? '',
        firstName: data['firstName'] ?? '',
        lastName: data['lastName'] ?? '',
        userName: data['userName'] ?? '',
        email: data['email'] ?? '',
        phoneNumber: data['phoneNumber'] ?? '',
        profilePicture: data['profilePicture'] ?? '',
        gymLocation: data['gymLocation'] ?? '',
        gymType: data['gymType'] ?? '',
        accountNumber: data['accountNumber'] ?? '',
        bankName: data['bankName'] ?? '',
      );
    } else {
      return GymOwnerModel.empty();
    }
  }

  factory GymOwnerModel.empty() {
    return GymOwnerModel(
      id: '',
      firstName: '',
      lastName: '',
      userName: '',
      email: '',
      phoneNumber: '',
      profilePicture: '',
      gymLocation: '',
      gymType: '',
      accountNumber: '',
      bankName: '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'userName': userName,
      'email': email,
      'phoneNumber': phoneNumber,
      'profilePicture': profilePicture,
      'gymLocation': gymLocation,
      'gymType': gymType,
      'accountNumber': accountNumber,
      'bankName': bankName,
    };
  }
}
