import '../../authentication/models/gym_model.dart';

class Gym {
  final String id;
  final String name;
  final String? description;
  final Location location; // This already includes latitude and longitude
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
        "location": location.toJson(), // Location will include coordinates
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
      };

  // Create Gym object from JSON
  factory Gym.fromJson(Map<String, dynamic> json) => Gym(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        location: Location.fromJson(json["location"]),
        // Parsing the location
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
