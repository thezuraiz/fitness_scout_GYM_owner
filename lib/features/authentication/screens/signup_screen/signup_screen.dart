import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/formDivider.dart';
import '../../../../common/widgets/socialButtons.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../controllers/signup/signup_controller.dart';
import '../widgets/signup_form.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = ZHelperFunction.isDarkMode(context);
    final controller = Get.put(SignupController());
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: ZSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TODO: Title
              Text(
                ZText.signupTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),

              const SizedBox(
                height: ZSizes.spaceBtwSections,
              ),

              // TODO: FORM Section
              const SignupForm(),
              const SizedBox(
                height: ZSizes.spaceBtwSections,
              ),

              /// Divider
              const ZFormDivider(dividerText: ZText.orSignUpWith),
              const SizedBox(
                height: ZSizes.spaceBtwSections,
              ),
              const ZSocialButtons()
            ],
          ),
        ),
      ),
    );
  }
}
