import 'dart:io';

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

    return Form(
      // key: controller.formKeys[0],
      child: Column(
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
          Text(
            'License Image:',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: ZSizes.spaceBtwInputFields / 2,
          ),
          GestureDetector(
            onTap: () => controller.pickImage(),
            child: Obx(() {
              // Ensure gymLicenseImage has a value before using it
              if (controller.gymLicenseImage.value != null) {
                // Convert XFile to File
                final file = File(controller.gymLicenseImage.value!.path);

                return Image.file(
                  file, // Use the File object here
                  fit: BoxFit.cover,
                  height: 100,
                  width: 100,
                );
              } else {
                return Container(
                  height: 85,
                  width: 85,
                  margin: const EdgeInsets.only(bottom: ZSizes.sm),
                  decoration: BoxDecoration(
                    borderRadius:
                        const BorderRadius.all(Radius.circular(ZSizes.md)),
                    color: Colors.grey.shade300,
                  ),
                  child: const Center(
                      child: Icon(
                    Icons.photo,
                    size: ZSizes.xl,
                  )),
                );
              }
            }),
          ),
          Obx(() {
            final isInvalid = controller.gymLicenseImage.value;
            return isInvalid == null
                ? Text(
                    'Required',
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: Colors.red.shade900,
                        fontWeight: FontWeight.w500),
                  )
                : const SizedBox
                    .shrink(); // Provide an empty widget when the condition is false
          }),
          const SizedBox(
            height: ZSizes.spaceBtwInputFields * 1.3,
          ),
          Text(
            'Select Available Amenities:',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: ZSizes.spaceBtwInputFields / 2,
          ),
          const AmenitiesWidget(),
          const SizedBox(
            height: ZSizes.spaceBtwInputFields * 1.5,
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
