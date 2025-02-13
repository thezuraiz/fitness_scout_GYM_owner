import 'package:fitness_scout_owner_v1/features/personalization/controller/change_user_settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:iconsax/iconsax.dart';

import '../../../common/widgets/custom_appbar/custom_app_bar.dart';
import '../../../utils/constants/sizes.dart';

class ChangeNumberScreen extends StatelessWidget {
  const ChangeNumberScreen({super.key, required this.number});

  final String number;

  @override
  Widget build(BuildContext context) {
    final controller = ChangeUserSettingsController.instance;
    controller.numberController.text = number;
    return Scaffold(
      appBar: ZCustomAppBar(
        showArrows: true,
        title: Text(
          'Owner Number',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(ZSizes.defaultSpace),
        child: Form(
          key: controller.updateFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Headline
              Text(
                'Update your number for better personalization.\n\nYour gym account will be temporarily suspended until our support team reviews and approves it. Do you wish to proceed?',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(
                height: ZSizes.spaceBtwSections,
              ),

              /// Input Field
              TextFormField(
                controller: controller.numberController,
                validator: MultiValidator([
                  RequiredValidator(errorText: 'This field is required!'),
                  MinLengthValidator(11, errorText: 'Minimum length is 11')
                ]),
                decoration: const InputDecoration(
                  labelText: 'Owner Number',
                  prefixIcon: Icon(Iconsax.user),
                ),
              ),
              const SizedBox(
                height: ZSizes.spaceBtwSections,
              ),

              /// Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.updateUserNumber,
                  child: const Text('Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
