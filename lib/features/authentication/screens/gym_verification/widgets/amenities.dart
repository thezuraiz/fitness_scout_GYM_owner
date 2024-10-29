import 'package:fitness_scout_owner_v1/features/authentication/controllers/gym_verification/gym_user_controller.dart';
import 'package:fitness_scout_owner_v1/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AmenitiesWidget extends StatelessWidget {
  const AmenitiesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final amenities = GYMUserController.instance.amenities.value;
      return Wrap(
        spacing: 8.0,
        runSpacing: 1.0,
        children: amenities.map((amenity) {
          return FilterChip(
            label: Text(amenity.name),
            selected: amenity.isSelected,
            onSelected: (bool selected) {
              amenity.isSelected = selected;
              GYMUserController.instance.amenities.refresh();
            },
            selectedColor: ZColor.primary.shade300,
            checkmarkColor: Colors.white,
          );
        }).toList(),
      );
    });
  }
}
