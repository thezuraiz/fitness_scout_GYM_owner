import 'package:fitness_scout_owner_v1/common/widgets/success_screen/successScreens.dart';
import 'package:fitness_scout_owner_v1/features/gym/screen/home/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/styles/AppbarPadding.dart';
import '../../../../utils/constants/image_string.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/device/deviceUtilities.dart';

class GymRegistrationWaitingList extends StatelessWidget {
  const GymRegistrationWaitingList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
                '',
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
              /// Success Screen
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.offAll(
                    () => SuccessScreen(
                      image: ZImages.successScreenAnimation,
                      title: ZText.yourAccountCreatedTitle,
                      subTitle: ZText.changeYourPasswordTitle,
                      onPressed: () => Get.offAll(const HomePage()),
                    ),
                  ),
                  child: const Text(ZText.Continue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
