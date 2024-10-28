import 'package:cloud_firestore/cloud_firestore.dart';

class GymOwnerModel {
  final String id;
  final String name;
  final String username;
  final String email;
  final String? phoneNumber;
  final String? profilePicture;
  final String? description;
  final String? gymName; // New optional field
  final Location? location;
  final String? address;
  final String? contactNumber;
  final String? website;
  final String? license;
  final Map<String, String>? openingHours;
  final List<String>? images;
  final List<String>? amenities;
  final OwnerBankDetails? ownerBankDetails;
  final double? balance;
  final bool? isApproved;
  final List<Visitor>? visitors;

  GymOwnerModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    this.phoneNumber,
    this.profilePicture,
    this.description,
    this.gymName, // Added here
    this.location,
    this.address,
    this.contactNumber,
    this.website,
    this.license,
    this.openingHours,
    this.images,
    this.amenities,
    this.ownerBankDetails,
    this.balance,
    this.isApproved,
    this.visitors,
  });

  // Convert Firestore document snapshot to GymOwnerModel
  factory GymOwnerModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return GymOwnerModel(
      id: snapshot.id,
      // Use the document ID
      name: data['name'] ?? '',
      username: data['username'] ?? '',
      email: data['email'] ?? '',
      phoneNumber: data['phone_number'],
      profilePicture: data['profile_picture'],
      description: data['description'],
      gymName: data['gym_name'],
      // Added here
      location:
          data['location'] != null ? Location.fromJson(data['location']) : null,
      address: data['address'],
      contactNumber: data['contact_number'],
      website: data['website'],
      license: data['license'],
      openingHours: data['opening_hours'] != null
          ? Map<String, String>.from(data['opening_hours'])
          : null,
      images: data['images'] != null ? List<String>.from(data['images']) : null,
      amenities: data['amenities'] != null
          ? List<String>.from(data['amenities'])
          : null,
      ownerBankDetails: data['owner_bank_details'] != null
          ? OwnerBankDetails.fromJson(data['owner_bank_details'])
          : null,
      balance: (data['balance'] ?? 0.0).toDouble(),
      isApproved: data['isApproved'] ?? false,
      visitors: (data['visitors'] as List<dynamic>?)
              ?.map((visitor) => Visitor.fromJson(visitor))
              .toList() ??
          [],
    );
  }

  // Convert GymOwnerModel object to JSON
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "username": username,
        "email": email,
        "phone_number": phoneNumber,
        "profile_picture": profilePicture,
        "description": description,
        "gym_name": gymName, // Added here
        "location": location?.toJson(),
        "address": address,
        "contact_number": contactNumber,
        "website": website,
        "license": license,
        "opening_hours": openingHours,
        "images": images,
        "amenities": amenities,
        "owner_bank_details": ownerBankDetails?.toJson(),
        "balance": balance,
        "isApproved": isApproved,
        "visitors": visitors?.map((v) => v.toJson()).toList(),
      };

  // Create an empty GymOwnerModel instance
  factory GymOwnerModel.empty() {
    return GymOwnerModel(
      id: '',
      name: '',
      username: '',
      email: '',
      phoneNumber: null,
      profilePicture: null,
      description: null,
      gymName: null,
      // Added here
      location: null,
      address: null,
      contactNumber: null,
      website: null,
      license: null,
      openingHours: null,
      images: null,
      amenities: null,
      ownerBankDetails: null,
      balance: null,
      isApproved: null,
      visitors: null,
    );
  }
}

// Define the Visitor model
class Visitor {
  final String userId;
  final DateTime checkInTime;
  final DateTime? checkOutTime;

  Visitor({
    required this.userId,
    required this.checkInTime,
    this.checkOutTime,
  });

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "check_in_time": checkInTime.toIso8601String(),
        "check_out_time": checkOutTime?.toIso8601String(),
      };

  factory Visitor.fromJson(Map<String, dynamic> json) => Visitor(
        userId: json["user_id"],
        checkInTime: DateTime.parse(json["check_in_time"]),
        checkOutTime: json["check_out_time"] != null
            ? DateTime.parse(json["check_out_time"])
            : null,
      );
}

// Define the Location model
class Location {
  final double latitude;
  final double longitude;

  Location({required this.latitude, required this.longitude});

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
      );
}

// Define the OwnerBankDetails model
class OwnerBankDetails {
  final String bankName;
  final String accountNumber;
  final String iban;

  OwnerBankDetails({
    required this.bankName,
    required this.accountNumber,
    required this.iban,
  });

  Map<String, dynamic> toJson() => {
        "bank_name": bankName,
        "account_number": accountNumber,
        "iban": iban,
      };

  factory OwnerBankDetails.fromJson(Map<String, dynamic> json) =>
      OwnerBankDetails(
        bankName: json["bank_name"],
        accountNumber: json["account_number"],
        iban: json["iban"],
      );
}
