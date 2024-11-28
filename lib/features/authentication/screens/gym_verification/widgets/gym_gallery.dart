import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/gym_verification/gym_user_controller.dart';

class GymGallery extends StatelessWidget {
  const GymGallery({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GYMUserController());
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'GYM Front Image:',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: ZSizes.spaceBtwInputFields / 2,
          ),
          GestureDetector(
            onTap: () => controller.pickImage(controller.gymFrontImage),
            child: Obx(() {
              if (controller.gymFrontImage.value != null) {
                final file = File(controller.gymFrontImage.value!.path);

                return Image.file(
                  file, // Use the File object here
                  fit: BoxFit.contain,
                  width: Get.width,
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
                    Icons.add_a_photo_outlined,
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
            onTap: () => controller.pickImage(controller.gymLicenseImage),
            child: Obx(() {
              // Ensure gymLicenseImage has a value before using it
              if (controller.gymLicenseImage.value != null) {
                // Convert XFile to File
                final file = File(controller.gymLicenseImage.value!.path);

                return Image.file(
                  file, // Use the File object here
                  fit: BoxFit.contain,
                  // height: 250,
                  width: Get.width,
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
                    Icons.add_a_photo_outlined,
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
        ],
      ),
    );
  }
}
