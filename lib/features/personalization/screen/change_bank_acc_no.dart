import 'package:fitness_scout_owner_v1/common/widgets/custom_appbar/custom_app_bar.dart';
import 'package:fitness_scout_owner_v1/features/personalization/controller/change_user_settings_controller.dart';
import 'package:fitness_scout_owner_v1/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:iconsax/iconsax.dart';

class ChangeAccountNumberScreen extends StatelessWidget {
  const ChangeAccountNumberScreen({super.key, required this.accNo});

  final String accNo;

  @override
  Widget build(BuildContext context) {
    final controller = ChangeUserSettingsController.instance;
    controller.bankAccountNoController.text = accNo;
    return Scaffold(
      appBar: ZCustomAppBar(
        showArrows: true,
        title: Text(
          'Bank Account Number',
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
                'Update your bank account number for better transactions. \n\nNote: Your gym account will be temporarily suspended until our support team reviews and approves it.',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(
                height: ZSizes.spaceBtwSections,
              ),

              /// Input Field
              TextFormField(
                controller: controller.bankAccountNoController,
                validator: MultiValidator([
                  RequiredValidator(errorText: 'This field is required!'),
                  MaxLengthValidator(50, errorText: 'Max alphabet 300'),
                  MinLengthValidator(3, errorText: 'Min value 3')
                ]),
                decoration: const InputDecoration(
                  labelText: 'Owner Bank Account Number',
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
                      'account_number',
                      controller.bankAccountNoController.text.trim()),
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
