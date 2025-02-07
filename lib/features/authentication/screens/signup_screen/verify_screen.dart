import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/styles/AppbarPadding.dart';
import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../utils/constants/image_string.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/device/deviceUtilities.dart';
import '../../controllers/signup/verifiy_email_controller.dart';

class VerifyScreen extends StatelessWidget {
  const VerifyScreen({super.key, required this.email});

  final email;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyEmailController());
    return Scaffold(
      /// The close icon in the App Bar is used to log out the user and redirect them to the user controller

      /// This approach is taken to handle scenarios where the user enters the registration process,
      /// and the data is stored, upon reopening the app, it checks if the email is verified

      /// If not verified, the app always navigates to the verification screen

      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => AuthenticationRepository.instance.logout(),
              icon: const Icon(CupertinoIcons.clear))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: ZAppbarPadding.appbarPadding,
          child: Column(
            children: [
              // --- TODO: Image
              Image.asset(
                ZImages.deliveredEmailIllustration,
                width: ZDeviceUtils.getScreenWidth() * 0.6,
              ),

              const SizedBox(
                height: ZSizes.spaceBtwSections,
              ),
              // --- TODO: Title & Subtitle
              Text(
                ZText.confirmEmailTitle,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: ZSizes.spaceBtwItems,
              ),
              Text(
                email ?? 'email',
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: ZSizes.spaceBtwItems,
              ),
              Text(
                ZText.confirmEmailSubtitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: ZSizes.spaceBtwSections,
              ),

              // --- TODO: Buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => controller.checkEmailVerificationStatus(),
                  child: const Text(ZText.Continue),
                ),
              ),
              const SizedBox(
                height: ZSizes.spaceBtwItems,
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => controller.sendEmailVerification(),
                  child: const Text(ZText.resendEmail),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
