class Amenity {
  String name;
  bool isSelected;

  Amenity({required this.name, this.isSelected = false});

  Map<String, dynamic> toJson() => {
        'name': name,
        'isSelected': isSelected,
      };

  // Optional: fromJson method for deserialization
  static Amenity fromJson(Map<String, dynamic> json) => Amenity(
        name: json['name'],
        isSelected: json['isSelected'] ?? false,
      );
}
