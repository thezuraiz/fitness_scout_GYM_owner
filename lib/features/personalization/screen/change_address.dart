import 'package:fitness_scout_owner_v1/features/personalization/controller/change_user_settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:iconsax/iconsax.dart';

import '../../../common/widgets/custom_appbar/custom_app_bar.dart';
import '../../../utils/constants/sizes.dart';

class ChangeAddressScreen extends StatelessWidget {
  const ChangeAddressScreen({super.key, required this.address});

  final String address;

  @override
  Widget build(BuildContext context) {
    final controller = ChangeUserSettingsController.instance;
    controller.addressController.text = address;
    return Scaffold(
      appBar: ZCustomAppBar(
        showArrows: true,
        title: Text(
          'GYM Address',
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
                'Update your address for better personalization. \n\nNote: Your gym account will be temporarily suspended until our support team reviews and approves it.',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(
                height: ZSizes.spaceBtwSections,
              ),

              /// Input Field
              TextFormField(
                controller: controller.addressController,
                validator: MultiValidator([
                  RequiredValidator(errorText: 'This field is required!'),
                  MaxLengthValidator(100, errorText: 'Max alphabet 100')
                ]),
                decoration: const InputDecoration(
                  labelText: 'Owner Address',
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
                  onPressed: controller.updateUserAddress,
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
