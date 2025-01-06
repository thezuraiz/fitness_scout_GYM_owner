import 'package:fitness_scout_owner_v1/features/authentication/screens/signup_screen/reset_password.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../controllers/forget_password/forget_password_controller.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: controller.forgetKey,
        child: Padding(
          padding: const EdgeInsets.all(ZSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TODO: Headings
              Text(
                ZText.forgetPasswordTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(
                height: ZSizes.spaceBtwItems,
              ),
              const Text(ZText.forgetPasswordSubTitle),
              const SizedBox(
                height: ZSizes.spaceBtwSections * 2,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: ZText.email,
                    prefixIcon: Icon(Iconsax.direct_right)),
                validator: controller.emailValidation.call,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: controller.email,
              ),
              const SizedBox(
                height: ZSizes.spaceBtwItems,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.sendPasswordResendEmail,
                  child: const Text(ZText.submit),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
