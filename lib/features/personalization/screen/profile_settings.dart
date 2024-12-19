import 'package:fitness_scout_owner_v1/features/authentication/controllers/gym_verification/gym_user_controller.dart';
import 'package:fitness_scout_owner_v1/features/personalization/screen/widgets/profile_menu.dart';
import 'package:fitness_scout_owner_v1/utils/helpers/logger.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../common/widgets/circular_image.dart';
import '../../../common/widgets/custom_appbar/custom_app_bar.dart';
import '../../../common/widgets/section_heading.dart';
import '../../../common/widgets/shimmer/shimmer.dart';
import '../../../utils/constants/image_string.dart';
import '../../../utils/constants/sizes.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = GYMUserController.instance;
    ZLogger.info('gym Owner: ${controller.GYMuser.value.gymName}');
    return Scaffold(
      appBar: ZCustomAppBar(
        showArrows: true,
        title: Text(
          "Profile",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: ZSizes.defaultSpace),
          child: Column(
            children: [
              // --- Profile Screen
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Obx(() {
                      final networkImage =
                          controller.GYMuser.value.images?.isNotEmpty == true
                              ? controller.GYMuser.value.images![0]
                              : null;

                      if (networkImage == null || networkImage.isEmpty) {
                        ZLogger.warning('No image found for the user.');
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              'No Image Available',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        );
                      }

                      ZLogger.info('Displaying Network Image: $networkImage');
                      return Container(
                        height: Get.height * 0.23,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(12),
                          ),
                          image: DecorationImage(
                            image: NetworkImage(networkImage),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }),
                    const SizedBox(
                      height: ZSizes.sm,
                    ),
                    TextButton(
                        onPressed: () {},
                        // UserController.instance.uploadUserProfilePicture(),
                        child: const Text("Change Profile Picture"))
                  ],
                ),
              ),

              // --- Details Page
              const Divider(),
              const SizedBox(
                height: ZSizes.spaceBtwItems,
              ),

              /// --- Profile Info
              const ZSectionHeading(
                title: "Profile Information",
                showActionButton: false,
              ),
              const SizedBox(
                height: ZSizes.spaceBtwItems,
              ),
              Obx(
                () => ProfileMenu(
                  title: "Name",
                  subTitle: controller.GYMuser.value.gymName!,
                  onPressed: () {},
                  // onPressed: () => Get.to(() => const ChangeNameScreen())),
                ),
              ),
              Obx(
                () => ProfileMenu(
                    title: "Username",
                    subTitle: controller.GYMuser.value.username,
                    onPressed: () {}),
              ),
              ProfileMenu(
                  title: "GYM Package", subTitle: "Diamond", onPressed: () {}),

              const SizedBox(
                height: ZSizes.spaceBtwItems,
              ),
              const Divider(),
              const SizedBox(
                height: ZSizes.spaceBtwItems,
              ),

              /// --- Personal Information
              const ZSectionHeading(
                title: "Personal Information",
                showActionButton: false,
              ),
              const SizedBox(
                height: ZSizes.spaceBtwItems,
              ),
              Obx(
                () => ProfileMenu(
                    title: "User ID",
                    subTitle: controller.GYMuser.value.id,
                    icon: Iconsax.copy,
                    onPressed: () {}),
              ),
              Obx(
                () => ProfileMenu(
                    title: "Email",
                    subTitle: controller.GYMuser.value.email,
                    onPressed: () {}),
              ),
              Obx(
                () => ProfileMenu(
                    title: "Phone Number",
                    subTitle: controller.GYMuser.value.contactNumber!,
                    onPressed: () {}),
              ),
              ProfileMenu(title: "Gender", subTitle: 'Male', onPressed: () {}),
              ProfileMenu(
                  title: "Date of Birth",
                  subTitle: '11-Aug-2003',
                  onPressed: () {}),
              const Divider(),
              const SizedBox(
                height: ZSizes.defaultSpace,
              ),

              /// --- Close Account
              Center(
                child: TextButton(
                  onPressed: () => controller.deleteAccountWarningPopUp(),
                  child: const Text("Close Account",
                      style: TextStyle(color: Colors.red)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
