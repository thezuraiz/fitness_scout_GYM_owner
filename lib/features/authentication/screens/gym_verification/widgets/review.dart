import 'package:fitness_scout_owner_v1/features/authentication/controllers/gym_verification/gym_user_controller.dart';
import 'package:fitness_scout_owner_v1/features/authentication/screens/gym_verification/widgets/amenities.dart';
import 'package:fitness_scout_owner_v1/features/authentication/screens/gym_verification/widgets/gym_gallery.dart';
import 'package:fitness_scout_owner_v1/utils/validator/validation.dart';
import 'package:flutter/material.dart';
import '../../../../../utils/constants/sizes.dart';
import 'package:get/get.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GYMUserController());
    return Form(
      key: controller.formKey,
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
          Text(
            'GYM Images:',
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: ZSizes.spaceBtwSections * 0.7,
          ),
          const GymGallery(),
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
            validator: (value) =>
                ZValidation.validateEmptyText('Account IBAN', value),
          ),
          const SizedBox(
            height: ZSizes.spaceBtwInputFields,
          ),
        ],
      ),
    );
  }
}
