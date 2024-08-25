import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../../utils/validator/validation.dart';
import '../../controllers/signup/signup_controller.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = ZHelperFunction.isDarkMode(context);
    final controller = Get.put(SignupController());
    return Form(
      key: controller.signupFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TODO: FORM Section

          Row(
            children: [
              /// First Name:
              Expanded(
                child: TextFormField(
                  controller: controller.firstName,
                  validator: (value) =>
                      ZValidation.validateEmptyText('First name', value),
                  decoration: const InputDecoration(
                      labelText: ZText.firstName,
                      prefixIcon: Icon(Iconsax.user)),
                ),
              ),
              const SizedBox(
                width: ZSizes.spaceBtwInputFields,
              ),

              /// Second Name:
              Expanded(
                child: TextFormField(
                  controller: controller.lastName,
                  validator: (value) =>
                      ZValidation.validateEmptyText('Last name', value),
                  decoration: const InputDecoration(
                      labelText: ZText.lastName,
                      prefixIcon: Icon(Iconsax.user)),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: ZSizes.spaceBtwInputFields,
          ),

          /// Username
          TextFormField(
            controller: controller.username,
            validator: (value) =>
                ZValidation.validateEmptyText('Username', value),
            decoration: const InputDecoration(
                labelText: ZText.userName, prefixIcon: Icon(Iconsax.user_edit)),
          ),
          const SizedBox(
            height: ZSizes.spaceBtwInputFields,
          ),

          /// Email
          TextFormField(
            controller: controller.email,
            validator: (value) => ZValidation.validateEmail(value),
            decoration: const InputDecoration(
                labelText: ZText.email, prefixIcon: Icon(Iconsax.activity)),
          ),
          const SizedBox(
            height: ZSizes.spaceBtwInputFields,
          ),

          /// Phone Number
          TextFormField(
            controller: controller.phoneNumber,
            validator: (value) => ZValidation.validatePhoneNumber(value),
            decoration: const InputDecoration(
              labelText: ZText.phoneNo,
              prefixIcon: Icon(Iconsax.call),
            ),
          ),
          const SizedBox(
            height: ZSizes.spaceBtwInputFields,
          ),

          /// Password
          Obx(
            () => TextFormField(
              controller: controller.password,
              obscureText: controller.hidePassword.value,
              // Todo:
              // validator: (value) => ZValidation.validatePassword(value),
              decoration: InputDecoration(
                labelText: ZText.password,
                prefixIcon: const Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                  onPressed: () => controller.hidePassword.value =
                      !controller.hidePassword.value,
                  icon: Icon(controller.hidePassword.value
                      ? Iconsax.eye
                      : Iconsax.eye_slash),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: ZSizes.spaceBtwSections,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Obx(
                () => SizedBox(
                  height: 24,
                  width: 24,
                  child: Checkbox(
                      value: controller.privacyPolicy.value,
                      onChanged: (value) => controller.privacyPolicy.value =
                          !controller.privacyPolicy.value),
                ),
              ),
              const SizedBox(
                width: ZSizes.md,
              ),
              Text.rich(
                TextSpan(children: [
                  TextSpan(
                      text: '${ZText.iAgreeTo} ',
                      style: Theme.of(context).textTheme.bodySmall),
                  TextSpan(
                    text: '${ZText.privacyPolicy} ',
                    style: Theme.of(context).textTheme.bodySmall!.apply(
                          color: dark ? Colors.white : ZColor.primary,
                          decoration: TextDecoration.underline,
                          decorationColor: dark ? Colors.white : ZColor.primary,
                        ),
                  ),
                  TextSpan(
                      text: 'and ',
                      style: Theme.of(context).textTheme.bodySmall),
                  TextSpan(
                    text: '${ZText.termsOfUse} ',
                    style: Theme.of(context).textTheme.bodySmall!.apply(
                          color: dark ? Colors.white : ZColor.primary,
                          decoration: TextDecoration.underline,
                          decorationColor: dark ? Colors.white : ZColor.primary,
                        ),
                  ),
                ]),
              ),
            ],
          ),
          const SizedBox(
            height: ZSizes.spaceBtwSections,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.signup(),
              child: const Text(ZText.createAccount),
            ),
          ),
        ],
      ),
    );
  }
}
