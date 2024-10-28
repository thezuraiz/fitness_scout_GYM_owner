import 'package:fitness_scout_owner_v1/features/authentication/controllers/gym_verification/gym_verification_controller.dart';
import 'package:fitness_scout_owner_v1/utils/validator/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../utils/constants/sizes.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GymVerificationController());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Let\'s Review your Data',
          style: Theme.of(Get.context!).textTheme.headlineMedium,
        ),
        const SizedBox(
          height: ZSizes.spaceBtwSections,
        ),
        TextFormField(
          decoration: const InputDecoration(labelText: 'GYM Name'),
          controller: controller.gymName,
          validator: (value) =>
              ZValidation.validateEmptyText('GYM Name', value),
        ),
        const SizedBox(
          height: ZSizes.spaceBtwInputFields,
        ),
        TextFormField(
          decoration: const InputDecoration(labelText: 'GYM Address'),
          controller: controller.gymAddress,
          validator: (value) =>
              ZValidation.validateEmptyText('GYM Address', value),
        ),
        const SizedBox(
          height: ZSizes.spaceBtwInputFields,
        ),
        TextFormField(
          decoration: const InputDecoration(labelText: 'GYM Location'),
          controller: controller.gymLocation,
          validator: (value) =>
              ZValidation.validateEmptyText('GYM Location', value),
        ),
        const SizedBox(
          height: ZSizes.spaceBtwInputFields,
        ),
        GestureDetector(
          onTap: () => controller.pickImage(),
          child: Obx(
            () => Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.all(10),
              child: controller.gymLicenseImage.value == null
                  ? const Column(
                      children: [
                        Icon(Icons.image, size: 50, color: Colors.grey),
                        SizedBox(height: 8),
                        Text('Select GYM License Image',
                            style: TextStyle(color: Colors.grey)),
                      ],
                    )
                  : Image.file(
                      controller.gymLicenseImage.value!,
                      fit: BoxFit.cover,
                      height: 100,
                      width: 100,
                    ),
            ),
          ),
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
        Text(
          'Let\'s Add Your Bank Details',
          style: Theme.of(Get.context!).textTheme.headlineMedium,
        ),
        const SizedBox(
          height: ZSizes.spaceBtwItems,
        ),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Bank Name'),
          controller: controller.gymOwnerBankName,
          validator: (value) =>
              ZValidation.validateEmptyText('Bank Name', value),
        ),
        const SizedBox(
          height: ZSizes.spaceBtwInputFields,
        ),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Account Number'),
          controller: controller.gymOwnerAccountNumber,
          validator: (value) =>
              ZValidation.validateEmptyText('Account Number', value),
        ),
        const SizedBox(
          height: ZSizes.spaceBtwInputFields,
        ),
        TextFormField(
          decoration: const InputDecoration(labelText: 'IBAN'),
          controller: controller.gymOwnerAccountIBAN,
          validator: (value) => ZValidation.validateEmptyText('IBAN', value),
        ),
        const SizedBox(
          height: ZSizes.spaceBtwInputFields,
        ),
      ],
    );
  }
}
