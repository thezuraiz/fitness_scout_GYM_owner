import 'package:fitness_scout_owner_v1/features/authentication/controllers/gym_verification/gym_user_controller.dart';
import 'package:fitness_scout_owner_v1/features/personalization/screen/change_user_settings.dart';
import 'package:fitness_scout_owner_v1/features/personalization/screen/widgets/profile_menu.dart';
import 'package:fitness_scout_owner_v1/utils/helpers/logger.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/widgets/custom_appbar/custom_app_bar.dart';
import '../../../common/widgets/section_heading.dart';
import '../../../utils/constants/sizes.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = GYMUserController.instance;
    final gymUser = controller.GYMuser;
    return Scaffold(
      appBar: ZCustomAppBar(
        showArrows: true,
        title: Text(
          "Profile",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => GYMUserController.instance.fetchUserRecord(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(ZSizes.defaultSpace),
            child: Column(
              children: [
                // --- Profile Screen
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Obx(() {
                        final networkImage =
                            gymUser.value.images?.isNotEmpty == true
                                ? controller.GYMuser.value.images![0]
                                : null;

                        if (networkImage == null || networkImage.isEmpty) {
                          ZLogger.warning('No image found for the user.');
                          return Container(
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                            width: double.infinity,
                            child: const Center(
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
                    title: "Owner Name",
                    subTitle: gymUser.value.name!,
                    onPressed: () => Get.to(
                      () => ChangeUserNameScreen(
                        name: gymUser.value.name!,
                      ),
                    ),
                  ),
                ),

                Obx(
                  () => ProfileMenu(
                    title: "Username",
                    subTitle: gymUser.value.username.split('@').first,
                  ),
                ),
                Obx(
                  () => ProfileMenu(
                    title: "Email",
                    subTitle: gymUser.value.email,
                  ),
                ),
                Obx(
                  () => ProfileMenu(
                      title: "Phone Number",
                      subTitle: gymUser.value.contactNumber!,
                      onPressed: () {}),
                ),
                Obx(
                  () => ProfileMenu(
                      title: "GYM Website",
                      subTitle: gymUser.value.website!,
                      onPressed: () {}),
                ),
                const SizedBox(
                  height: ZSizes.spaceBtwItems,
                ),
                const Divider(),
                const SizedBox(
                  height: ZSizes.spaceBtwItems,
                ),

                /// --- Personal Information
                const ZSectionHeading(
                  title: "GYM Information",
                  showActionButton: false,
                ),
                const SizedBox(
                  height: ZSizes.spaceBtwItems,
                ),
                Obx(
                  () => ProfileMenu(
                    title: "Name",
                    subTitle: gymUser.value.gymName!,
                    onPressed: () {},
                    // onPressed: () => Get.to(() => const ChangeNameScreen())),
                  ),
                ),
                Obx(
                  () => ProfileMenu(
                    title: "Description",
                    subTitle: gymUser.value.gymName!,
                    onPressed: () {},
                    // onPressed: () => Get.to(() => const ChangeNameScreen())),
                  ),
                ),
                Obx(
                  () => ProfileMenu(
                    title: "Address",
                    subTitle: gymUser.value.gymName!,
                    onPressed: () {},
                    // onPressed: () => Get.to(() => const ChangeNameScreen())),
                  ),
                ),
                Obx(() {
                  final List<String> amenities = gymUser.value.amenities!
                      .map((e) => e['name'].toString())
                      .toList();
                  return ProfileMenu(
                    title: "Amenities",
                    subTitle: amenities.join(', '),
                    onPressed: () {},
                    // onPressed: () => Get.to(() => const ChangeNameScreen())),
                  );
                }),
                ProfileMenu(
                  title: "Opening Hours",
                  subTitle: 'Tap to view',
                  // Joins list elements with a comma and space
                  onPressed: () {},
                  // onPressed: () => Get.to(() => const ChangeNameScreen())),
                ),
                const SizedBox(
                  height: ZSizes.spaceBtwItems,
                ),
                const Divider(),
                const SizedBox(
                  height: ZSizes.spaceBtwItems,
                ),

                /// --- Personal Information
                const ZSectionHeading(
                  title: "Banking Information",
                  showActionButton: false,
                ),
                const SizedBox(
                  height: ZSizes.spaceBtwItems,
                ),
                Obx(
                  () => ProfileMenu(
                    title: "Bank Name",
                    subTitle: gymUser.value.ownerBankDetails!.bankName,
                    onPressed: () {},
                    // onPressed: () => Get.to(() => const ChangeNameScreen())),
                  ),
                ),
                Obx(
                  () => ProfileMenu(
                    title: "Account No",
                    subTitle: gymUser.value.ownerBankDetails!.accountNumber,
                    onPressed: () {},
                    // onPressed: () => Get.to(() => const ChangeNameScreen())),
                  ),
                ),
                Obx(
                  () => ProfileMenu(
                    title: "Account IBAN",
                    subTitle: gymUser.value.ownerBankDetails!.iban,
                    onPressed: () {},
                    // onPressed: () => Get.to(() => const ChangeNameScreen())),
                  ),
                ),
                const SizedBox(
                  height: ZSizes.spaceBtwItems,
                ),
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
      ),
    );
  }
}
