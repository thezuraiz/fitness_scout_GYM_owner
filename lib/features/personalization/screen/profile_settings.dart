import 'package:fitness_scout_owner_v1/features/authentication/controllers/gym_verification/gym_user_controller.dart';
import 'package:fitness_scout_owner_v1/features/personalization/controller/change_user_settings_controller.dart';
import 'package:fitness_scout_owner_v1/features/personalization/screen/change_address.dart';
import 'package:fitness_scout_owner_v1/features/personalization/screen/change_bank_iban.dart';
import 'package:fitness_scout_owner_v1/features/personalization/screen/change_bank_name.dart';
import 'package:fitness_scout_owner_v1/features/personalization/screen/change_description.dart';
import 'package:fitness_scout_owner_v1/features/personalization/screen/change_number.dart';
import 'package:fitness_scout_owner_v1/features/personalization/screen/change_user_settings.dart';
import 'package:fitness_scout_owner_v1/features/personalization/screen/change_website.dart';
import 'package:fitness_scout_owner_v1/features/personalization/screen/change_bank_acc_no.dart';
import 'package:fitness_scout_owner_v1/features/personalization/screen/widgets/amenities_screen.dart';
import 'package:fitness_scout_owner_v1/features/personalization/screen/widgets/blured_profile_menue.dart';
import 'package:fitness_scout_owner_v1/features/personalization/screen/widgets/profile_menu.dart';
import 'package:fitness_scout_owner_v1/utils/helpers/logger.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../common/widgets/custom_appbar/custom_app_bar.dart';
import '../../../common/widgets/section_heading.dart';
import '../../../utils/constants/sizes.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = GYMUserController.instance;
    final gymUser = controller.GYMuser;
    Get.put(ChangeUserSettingsController());
    return Scaffold(
      appBar: ZCustomAppBar(
        showArrows: true,
        title: Text(
          "Profile Settings",
          style: Theme.of(context).textTheme.headlineSmall,
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
                        onPressed: () =>
                            GYMUserController.instance.uploadGYMPicture(),
                        child: const Text("Change GYM Picture"),
                      )
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
                    subTitle: gymUser.value.name,
                    onPressed: () => Get.to(
                      () => ChangeUserNameScreen(
                        name: gymUser.value.name,
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
                    title: "Phone No",
                    subTitle: gymUser.value.contactNumber!,
                    onPressed: () => Get.to(
                      () => ChangeNumberScreen(
                          number: gymUser.value.contactNumber!),
                    ),
                  ),
                ),
                Obx(
                  () => ProfileMenu(
                    title: "Is Verified",
                    subTitle: gymUser.value.isApproved.name == 'APPROVED'
                        ? 'True'
                        : gymUser.value.isApproved.name == 'NOT_APPROVED'
                            ? 'False'
                            : 'Pending',
                  ),
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
                    // onPressed: () {},
                  ),
                ),
                Obx(
                  () => ProfileMenu(
                    title: "Description",
                    subTitle: gymUser.value.description!,
                    onPressed: () => Get.to(() => ChangeDescriptionScreen(
                        description: gymUser.value.description!)),
                    // onPressed: () => Get.to(() => const ChangeNameScreen())),
                  ),
                ),
                Obx(
                  () => ProfileMenu(
                    title: "Address",
                    subTitle: gymUser.value.address!,
                    onPressed: () => Get.to(
                      () =>
                          ChangeAddressScreen(address: gymUser.value.address!),
                    ),
                  ),
                ),
                Obx(
                  () => ProfileMenu(
                    title: "GYM Website",
                    subTitle: gymUser.value.website!,
                    onPressed: () => Get.to(
                      () =>
                          ChangeWebsiteScreen(website: gymUser.value.website!),
                    ),
                  ),
                ),
                Obx(
                  () => ProfileMenu(
                    title: "GYM Type",
                    subTitle: gymUser.value.gymType.name,
                  ),
                ),
                Obx(() {
                  final List<String> amenities = gymUser.value.amenities!
                      .map((e) => e['name'].toString())
                      .toList();
                  return ProfileMenu(
                    title: "Amenities",
                    subTitle: amenities.join(', '),
                    onPressed: () => Get.to(
                      () => AmenitiesScreen(
                        amenities: amenities,
                      ),
                    ),
                  );
                }),
                // ProfileMenu(
                //   title: "Opening Hours",
                //   subTitle: 'Tap to view',
                //   // Joins list elements with a comma and space
                //   onPressed: () {},
                //   // onPressed: () => Get.to(() => const ChangeNameScreen())),
                // ),
                const SizedBox(
                  height: ZSizes.spaceBtwItems,
                ),
                const ZSectionHeading(
                  title: 'GYM License',
                  showActionButton: false,
                ),
                const SizedBox(
                  height: ZSizes.spaceBtwItems,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Obx(() {
                        final networkImage =
                            gymUser.value.license?.isNotEmpty == true
                                ? controller.GYMuser.value.license!
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
                        onPressed: () => controller.uploadGYMLicense(),
                        child: const Text("Change License Image"),
                      )
                    ],
                  ),
                ),
                const Divider(),
                const SizedBox(
                  height: ZSizes.spaceBtwItems / 2.5,
                ),

                /// --- Personal Information
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Banking Information",
                      style: Theme.of(context).textTheme.headlineSmall!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Obx(
                      () => IconButton(
                        onPressed: () => controller.showBankDetails.value =
                            !controller.showBankDetails.value,
                        icon: Icon(!controller.showBankDetails.value
                            ? Iconsax.eye
                            : Iconsax.eye_slash),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: ZSizes.spaceBtwItems / 2,
                ),
                Obx(
                  () => controller.showBankDetails.value
                      ? ProfileMenu(
                          title: "Bank Name",
                          subTitle: gymUser.value.ownerBankDetails!.bankName,
                          onPressed: () => Get.to(
                            () => ChangeBankNameScreen(
                                bankName:
                                    gymUser.value.ownerBankDetails!.bankName),
                          ),
                        )
                      : const BluredProfileMenue(title: 'Bank Name'),
                ),

                Obx(
                  () => controller.showBankDetails.value
                      ? ProfileMenu(
                          title: "Account No",
                          subTitle:
                              gymUser.value.ownerBankDetails!.accountNumber,
                          onPressed: () => Get.to(
                            () => ChangeAccountNumberScreen(
                                accNo: gymUser
                                    .value.ownerBankDetails!.accountNumber),
                          ),
                        )
                      : const BluredProfileMenue(title: 'Account No'),
                ),
                Obx(
                  () => controller.showBankDetails.value
                      ? ProfileMenu(
                          title: "Account IBAN",
                          subTitle: gymUser.value.ownerBankDetails!.iban,
                          onPressed: () => Get.to(
                            () => ChangeAccountIBANScreen(
                                bankIBAN: gymUser.value.ownerBankDetails!.iban),
                          ),
                        )
                      : const BluredProfileMenue(title: 'Account IBAN'),
                ),
                const SizedBox(
                  height: ZSizes.spaceBtwItems,
                ),
                const Divider(),
                const SizedBox(
                  height: ZSizes.defaultSpace,
                ),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      GYMUserController.instance.deleteAccountWarningPopUp();
                    },
                    child: Text(
                      'Delete Account',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.red),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
