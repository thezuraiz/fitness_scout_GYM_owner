class Gym {
  final String id;
  final String name;
  final String? description;
  final Location location;
  final String address;
  final String contactNumber;
  final String? website;
  final String license;
  final Map<String, String> openingHours;
  final List<String> images;
  final List<String> amenities;
  final OwnerBankDetails ownerBankDetails;
  final double balance;
  final bool isApproved;
  final List<Visitor> visitors; // New field to track gym visitors

  Gym({
    required this.id,
    required this.name,
    this.description,
    required this.location,
    required this.address,
    required this.contactNumber,
    this.website,
    required this.license,
    required this.openingHours,
    required this.images,
    required this.amenities,
    required this.ownerBankDetails,
    this.balance = 0.0,
    this.isApproved = false,
    this.visitors = const [], // Default to an empty list
  });

  // Convert Gym object to JSON
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "location": location.toJson(),
        "address": address,
        "contact_number": contactNumber,
        "website": website,
        "license": license,
        "opening_hours": openingHours,
        "images": images,
        "amenities": amenities,
        "owner_bank_details": ownerBankDetails.toJson(),
        "balance": balance,
        "isApproved": isApproved,
        "visitors": visitors.map((v) => v.toJson()).toList(),
        // Convert each visitor to JSON
      };

  // Create Gym object from JSON
  factory Gym.fromJson(Map<String, dynamic> json) => Gym(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        location: Location.fromJson(json["location"]),
        address: json["address"],
        contactNumber: json["contact_number"],
        website: json["website"],
        license: json["license"],
        openingHours: Map<String, String>.from(json["opening_hours"]),
        images: List<String>.from(json["images"]),
        amenities: List<String>.from(json["amenities"]),
        ownerBankDetails: OwnerBankDetails.fromJson(json["owner_bank_details"]),
        balance: (json["balance"] ?? 0.0).toDouble(),
        isApproved: json["isApproved"] ?? false,
        visitors: (json["visitors"] as List<dynamic>?)
                ?.map((visitor) => Visitor.fromJson(visitor))
                .toList() ??
            [], // Parse each visitor JSON
      );
}

// Define a Visitor model to track each visitor's details
class Visitor {
  final String userId;
  final DateTime checkInTime;
  final DateTime?
      checkOutTime; // Optional, can be null if user hasn't checked out

  Visitor({
    required this.userId,
    required this.checkInTime,
    this.checkOutTime,
  });

  // Convert Visitor object to JSON
  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "check_in_time": checkInTime.toIso8601String(),
        "check_out_time": checkOutTime?.toIso8601String(),
      };

  // Create Visitor object from JSON
  factory Visitor.fromJson(Map<String, dynamic> json) => Visitor(
        userId: json["user_id"],
        checkInTime: DateTime.parse(json["check_in_time"]),
        checkOutTime: json["check_out_time"] != null
            ? DateTime.parse(json["check_out_time"])
            : null,
      );
}

class Location {
  final double latitude;
  final double longitude;

  Location({required this.latitude, required this.longitude});

  // Convert Location object to JSON
  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };

  // Create Location object from JSON
  factory Location.fromJson(Map<String, dynamic> json) => Location(
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
      );
}

class OwnerBankDetails {
  final String bankName;
  final String accountNumber;
  final String iban;

  OwnerBankDetails({
    required this.bankName,
    required this.accountNumber,
    required this.iban,
  });

  // Convert OwnerBankDetails object to JSON
  Map<String, dynamic> toJson() => {
        "bank_name": bankName,
        "account_number": accountNumber,
        "iban": iban,
      };

  // Create OwnerBankDetails object from JSON
  factory OwnerBankDetails.fromJson(Map<String, dynamic> json) =>
      OwnerBankDetails(
        bankName: json["bank_name"],
        accountNumber: json["account_number"],
        iban: json["iban"],
      );
}
