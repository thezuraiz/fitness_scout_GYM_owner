import 'package:fitness_scout_owner_v1/features/authentication/controllers/gym_verification/gym_verification_controller.dart';
import 'package:fitness_scout_owner_v1/utils/validator/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants/sizes.dart';

class GymInfoScreen extends StatelessWidget {
  const GymInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GymVerificationController());
    return Form(
      key: controller.formKeyStep1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Let\'s Register Your GYM',
            style: Theme.of(Get.context!).textTheme.headlineMedium,
          ),
          const SizedBox(
            height: ZSizes.spaceBtwSections,
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
            decoration: const InputDecoration(labelText: 'GYM Address'),
            validator: (value) =>
                ZValidation.validateEmptyText('GYM Address', value),
            controller: controller.gymAddress,
          ),
          const SizedBox(
            height: ZSizes.spaceBtwInputFields,
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'GYM Location'),
            validator: (value) =>
                ZValidation.validateEmptyText('GYM Location', value),
            controller: controller.gymLocation,
          ),
          const SizedBox(
            height: ZSizes.spaceBtwInputFields,
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'GYM License'),
            validator: (value) =>
                ZValidation.validateEmptyText('GYM License', value),
            controller: controller.gymLicence,
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
            height: ZSizes.spaceBtwInputFields,
          ),
        ],
      ),
    );
  }
}
