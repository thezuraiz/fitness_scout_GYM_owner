import 'package:fitness_scout_owner_v1/features/authentication/controllers/gym_verification/gym_user_controller.dart';
import 'package:fitness_scout_owner_v1/utils/validator/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants/sizes.dart';
import 'amenities.dart';

class GymInfoScreen extends StatelessWidget {
  const GymInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GYMUserController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Let\'s Register Your GYM',
          style: Theme.of(Get.context!).textTheme.headlineMedium,
        ),
        const SizedBox(
          height: ZSizes.spaceBtwSections * 0.7,
        ),
        TextFormField(
          decoration: const InputDecoration(labelText: 'GYM Name'),
          validator: (value) =>
              ZValidation.validateEmptyText('GYM Name', value),
          controller: controller.gymName,
        ),
        const SizedBox(
          height: ZSizes.spaceBtwInputFields,
        ),
        TextFormField(
          decoration: const InputDecoration(labelText: 'GYM Description'),
          validator: (value) =>
              ZValidation.validateEmptyText('GYM Description', value),
          controller: controller.gymDescription,
        ),
        const SizedBox(
          height: ZSizes.spaceBtwInputFields,
        ),
        TextFormField(
          decoration: const InputDecoration(labelText: 'GYM Address'),
          validator: (value) =>
              ZValidation.validateEmptyText('GYM Address', value),
          controller: controller.gymAddress,
        ),
        const SizedBox(
          height: ZSizes.spaceBtwInputFields,
        ),
        TextFormField(
          decoration:
              const InputDecoration(labelText: 'GYM Website (Optional)'),
          controller: controller.gymWebsite,
        ),
        const SizedBox(
          height: ZSizes.spaceBtwInputFields * 1.5,
        ),
        Text(
          'Select Available Amenities:',
          style: Theme.of(Get.context!).textTheme.headlineMedium,
        ),
        const SizedBox(
          height: ZSizes.spaceBtwInputFields / 2,
        ),
        const AmenitiesWidget(),
        const SizedBox(
          height: ZSizes.spaceBtwInputFields,
        ),
      ],
    );
  }
}
