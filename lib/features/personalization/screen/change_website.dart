import 'package:fitness_scout_owner_v1/features/personalization/controller/change_user_settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:iconsax/iconsax.dart';

import '../../../common/widgets/custom_appbar/custom_app_bar.dart';
import '../../../utils/constants/sizes.dart';

class ChangeWebsiteScreen extends StatelessWidget {
  const ChangeWebsiteScreen({super.key, required this.website});

  final String website;

  @override
  Widget build(BuildContext context) {
    final controller = ChangeUserSettingsController.instance;
    controller.websiteController.text = website;
    return Scaffold(
      appBar: ZCustomAppBar(
        showArrows: true,
        title: Text(
          'Owner Website',
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
                'Update your website for better personalization.',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(
                height: ZSizes.spaceBtwSections,
              ),

              /// Input Field
              TextFormField(
                controller: controller.websiteController,
                validator: MultiValidator([
                  RequiredValidator(errorText: 'This field is required!'),
                  PatternValidator('.com', errorText: 'Invalid Link')
                ]),
                decoration: const InputDecoration(
                  labelText: 'Owner Website',
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
                  onPressed: controller.updateUserWebsite,
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
