import 'package:fitness_scout_owner_v1/features/authentication/controllers/gym_verification/gym_verification_controller.dart';
import 'package:fitness_scout_owner_v1/utils/validator/validation.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/constants/sizes.dart';
import 'package:get/get.dart';

class BankInfoScreen extends StatelessWidget {
  const BankInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GymVerificationController());
    return Form(
      key: controller.formKeyStep2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
            controller: controller.gymOwnerAccountNumber,
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
