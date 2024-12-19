import 'package:fitness_scout_owner_v1/features/personalization/controller/change_user_settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:iconsax/iconsax.dart';

import '../../../common/widgets/custom_appbar/custom_app_bar.dart';
import '../../../utils/constants/sizes.dart';

class ChangeAccountIBANScreen extends StatelessWidget {
  const ChangeAccountIBANScreen({super.key, required this.bankIBAN});

  final String bankIBAN;

  @override
  Widget build(BuildContext context) {
    final controller = ChangeUserSettingsController.instance;
    controller.bankAccountIBANController.text = bankIBAN;
    return Scaffold(
      appBar: ZCustomAppBar(
        showArrows: true,
        title: Text(
          'GYM Bank IBAN',
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
                'Update your bank IBAN for better transactions.',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(
                height: ZSizes.spaceBtwSections,
              ),

              /// Input Field
              TextFormField(
                controller: controller.bankAccountIBANController,
                validator: MultiValidator([
                  RequiredValidator(errorText: 'This field is required!'),
                  MaxLengthValidator(50, errorText: 'Max alphabet 300'),
                  MinLengthValidator(3, errorText: 'Min value 3')
                ]),
                decoration: const InputDecoration(
                  labelText: 'Owner Bank IBAN',
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
                  onPressed: () => controller.updateBankDetails(
                      'iban', controller.bankAccountIBANController.text.trim()),
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
