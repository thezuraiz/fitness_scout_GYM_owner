import 'package:fitness_scout_owner_v1/utils/validator/validation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../controllers/login/login_controller.dart';
import '../signup_screen/forget_password.dart';
import '../signup_screen/signup_screen.dart';

class LoginScreenFormField extends StatelessWidget {
  const LoginScreenFormField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Form(
      key: controller.loginKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: ZSizes.spaceBtwSections),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: ZText.email,
                prefixIcon: Icon(Iconsax.direct_right),
              ),
              controller: controller.email,
              validator: (value) => ZValidation.validateEmail(value),
            ),
            const SizedBox(
              height: ZSizes.spaceBtwInputFields,
            ),
            Obx(
              () => TextFormField(
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () => controller.hidePassword.value =
                            !controller.hidePassword.value,
                        icon: Icon(controller.hidePassword.value
                            ? Iconsax.eye
                            : Iconsax.eye_slash)),
                    prefixIcon: const Icon(Iconsax.password_check),
                    labelText: ZText.password),
                controller: controller.password,
                obscureText: controller.hidePassword.value,
                // Todo: Uncomment validation in production mode
                // validator: (value) => ZValidation.validatePassword(value),
              ),
            ),

            const SizedBox(
              height: ZSizes.spaceBtwInputFields / 2,
            ),

            // TODO: Remember Me
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Obx(() => Checkbox(
                        value: controller.rememberMe.value,
                        onChanged: (value) => controller.rememberMe.value =
                            !controller.rememberMe.value)),
                    const Text(ZText.rememberMe)
                  ],
                ),

                // TODO: Forget Password
                TextButton(
                  onPressed: () => Get.to(const ForgetPassword()),
                  child: const Text(ZText.forgetPassword),
                )
              ],
            ),

            // TODO: Sign In Button
            const SizedBox(
              height: ZSizes.spaceBtwSections,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.loginWithEmailAndPassword(),
                child: const Text(ZText.signIn),
              ),
            ),
            const SizedBox(
              height: ZSizes.spaceBtwSections,
            ),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Get.to(() => const SignupScreen()),
                child: const Text(ZText.createAccount),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
