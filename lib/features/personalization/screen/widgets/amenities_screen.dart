import 'package:fitness_scout_owner_v1/common/widgets/custom_appbar/custom_app_bar.dart';
import 'package:fitness_scout_owner_v1/utils/constants/colors.dart';
import 'package:fitness_scout_owner_v1/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class AmenitiesScreen extends StatelessWidget {
  const AmenitiesScreen({super.key, required this.amenities});

  final List<String> amenities;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ZCustomAppBar(
        title: Text('Amenities'),
        showArrows: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ZSizes.md),
          child: Wrap(
            spacing: ZSizes.sm,
            children: amenities
                .map(
                  (amenity) => Chip(
                    label: Text(amenity.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall!
                            .copyWith(color: Colors.white, fontSize: 12)),
                    backgroundColor: ZColor.primary,
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
