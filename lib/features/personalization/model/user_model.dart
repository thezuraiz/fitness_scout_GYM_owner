import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  String firstName;
  String lastName;
  final String userName;
  final String email;
  String phoneNumber;
  String profilePicture;
  double height;
  double weight;
  double bmi;
  List<GymUserAttendance> userAttendance;
  final int totalVisits;

  String get fullName => '$firstName $lastName';

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
    this.height = 0.0,
    this.weight = 0.0,
    this.bmi = 0.0,
    this.totalVisits = 0,
    this.userAttendance = const [],
  });

  // Factory method to create an empty UserModel
  factory UserModel.empty() {
    return UserModel(
      id: '',
      firstName: '',
      lastName: '',
      userName: '',
      email: '',
      phoneNumber: '',
      profilePicture: '',
      height: 0.0,
      weight: 0.0,
      bmi: 0.0,
      totalVisits: 0,
      userAttendance: [],
    );
  }

  // Factory method to create a UserModel from a JSON map
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      userName: json['userName'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      profilePicture: json['profilePicture'] as String,
      height: (json['height'] as num).toDouble(),
      weight: (json['weight'] as num).toDouble(),
      bmi: (json['bmi'] as num).toDouble(),
      totalVisits: json['totalVisits'] ?? 0,
      userAttendance: (json['userAttendance'] as List<dynamic>?)
              ?.map((item) => GymUserAttendance.fromMap(item))
              .toList() ??
          [],
    );
  }

  /// Factory method to create a UserModel from a Firestore snapshot
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data() ?? {};
    return UserModel(
      id: snapshot.id,
      firstName: data['firstName'] ?? '',
      lastName: data['lastName'] ?? '',
      userName: data['userName'] ?? '',
      email: data['email'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      profilePicture: data['profilePicture'] ?? '',
      height: (data['height'] ?? 0.0).toDouble(),
      weight: (data['weight'] ?? 0.0).toDouble(),
      bmi: (data['bmi'] ?? 0.0).toDouble(),
      totalVisits: data['totalVisits'] ?? 0,
      userAttendance: (data['userAttendance'] as List<dynamic>?)
              ?.map((item) => GymUserAttendance.fromMap(item))
              .toList() ??
          [],
    );
  }

  // Method to convert a UserModel to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'userName': userName,
      'email': email,
      'phoneNumber': phoneNumber,
      'profilePicture': profilePicture,
      'height': height,
      'weight': weight,
      'bmi': bmi,
      'totalVisits': totalVisits,
      'userAttendance': userAttendance.map((item) => item.toMap()).toList(),
    };
  }

  // Method to create a copy of the UserModel with modifications
  UserModel copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? userName,
    String? email,
    String? phoneNumber,
    String? profilePicture,
    double? height,
    double? weight,
    double? bmi,
    int? totalVisits,
    List<GymUserAttendance>? userAttendance,
  }) {
    return UserModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profilePicture: profilePicture ?? this.profilePicture,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      bmi: bmi ?? this.bmi,
      totalVisits: totalVisits ?? this.totalVisits,
      userAttendance: userAttendance ?? this.userAttendance,
    );
  }

  @override
  String toString() {
    return 'UserModel(id: $id, firstName: $firstName, lastName: $lastName, userName: $userName, email: $email, phoneNumber: $phoneNumber, profilePicture: $profilePicture, height: $height, weight: $weight, bmi: $bmi, totalVisits: $totalVisits, userAttendance: $userAttendance)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.id == id &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.userName == userName &&
        other.email == email &&
        other.phoneNumber == phoneNumber &&
        other.profilePicture == profilePicture &&
        other.height == height &&
        other.weight == weight &&
        other.bmi == bmi &&
        other.totalVisits == totalVisits &&
        other.userAttendance == userAttendance;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        userName.hashCode ^
        email.hashCode ^
        phoneNumber.hashCode ^
        profilePicture.hashCode ^
        height.hashCode ^
        weight.hashCode ^
        bmi.hashCode ^
        totalVisits.hashCode ^
        userAttendance.hashCode;
  }
}

class GymUserAttendance {
  final String id;
  final String name, phoneNo, location;
  final DateTime checkOutTime;
  final DateTime checkInTime;

  GymUserAttendance({
    required this.id,
    required this.name,
    this.phoneNo = '',
    this.location = '',
    required this.checkInTime,
    required this.checkOutTime,
  });

  factory GymUserAttendance.empty() {
    return GymUserAttendance(
      id: '',
      name: '',
      location: '',
      phoneNo: '',
      checkInTime: DateTime.fromMillisecondsSinceEpoch(0),
      checkOutTime: DateTime.fromMillisecondsSinceEpoch(0),
    );
  }

  factory GymUserAttendance.fromMap(Map<String, dynamic> map) {
    return GymUserAttendance(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      phoneNo: map['phoneNo'] ?? '',
      location: map['location'] ?? '',
      checkInTime: DateTime.parse(map['checkInTime']),
      checkOutTime: DateTime.parse(map['checkOutTime']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phoneNo': phoneNo,
      'location': location,
      'checkInTime': checkInTime.toIso8601String(),
      'checkOutTime': checkOutTime.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'GymUserAttendance(id: $id, name: $name, checkInTime: $checkInTime, checkOutTime: $checkOutTime)';
  }
}
