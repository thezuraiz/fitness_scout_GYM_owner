import 'dart:typed_data';
import 'dart:ui';

import 'package:esys_flutter_share_plus/esys_flutter_share_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_scout_owner_v1/utils/helpers/logger.dart';
import 'package:fitness_scout_owner_v1/utils/popups/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

import 'package:fitness_scout_owner_v1/common/widgets/cards/custom_cards.dart';
import 'package:fitness_scout_owner_v1/common/widgets/drawer/custom_drawer.dart';
import 'package:fitness_scout_owner_v1/features/authentication/controllers/gym_verification/gym_user_controller.dart';
import 'package:fitness_scout_owner_v1/features/gym/controller/home_controller.dart';
import 'package:fitness_scout_owner_v1/features/gym/controller/upcoming_event.dart';
import 'package:fitness_scout_owner_v1/features/gym/screen/upcoming_event/events.dart';
import 'package:fitness_scout_owner_v1/features/gym/screen/visitors_screen.dart';
import 'package:fitness_scout_owner_v1/features/personalization/screen/profile_settings.dart';
import 'package:fitness_scout_owner_v1/utils/constants/colors.dart';
import 'package:fitness_scout_owner_v1/utils/constants/sizes.dart';
import 'package:fitness_scout_owner_v1/utils/helpers/helper_functions.dart';

import '../../../personalization/model/user_model.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = ZHelperFunction.isDarkMode(context);
    final userController = Get.put(GYMUserController());
    final upcomingEventsController = Get.put(UpcomingEventsController());
    final homeController = Get.put(HomeController());

    return Scaffold(
      drawer: const CustomDrawer(),
      body: RefreshIndicator(
        onRefresh: () => homeController.reloadProfile(),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: ZSizes.sm,
            horizontal: ZSizes.sm,
          ),
          child: ListView(
            shrinkWrap: true,
            children: [
              _buildHeader(context),
              _buildQRCodeSection(dark, upcomingEventsController),
              _buildBalanceSection(userController),
              _buildOngoingUsersList(homeController, context),
              _buildVisitorsHistory(),
              _buildUpcomingEvents(upcomingEventsController),
              const SizedBox(height: ZSizes.lg),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Builder(
            builder: (context) {
              return IconButton(
                onPressed: () {
                  if (Scaffold.of(context).hasDrawer) {
                    Scaffold.of(context).openDrawer();
                  } else {
                    ZLogger.error("No Drawer found!");
                  }
                },
                icon: const Icon(
                  Iconsax.menu_1,
                  size: ZSizes.iconMd * 1.3,
                ),
              );
            },
          ),
          IconButton(
            onPressed: () => Get.to(() => const SettingScreen()),
            icon: const Icon(
              Iconsax.check,
              size: ZSizes.iconMd * 1.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQRCodeSection(bool dark, UpcomingEventsController controller) {
    return Obx(
      () => controller.showDelayOnQr.value
          ? const Center(
              child: SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(color: ZColor.primary)),
            )
          : Center(
              child: InkWell(
                onTap: () => _shareQRCode(),
                child: RepaintBoundary(
                  key: qrKey,
                  child: SizedBox(
                    height: Get.width / 1.5,
                    child: PrettyQrView.data(
                      data: FirebaseAuth.instance.currentUser!.uid.toString(),
                      decoration: PrettyQrDecoration(
                        shape: PrettyQrSmoothSymbol(
                          color: dark ? ZColor.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  Widget _buildBalanceSection(GYMUserController userController) {
    RxBool showWalletAmount = false.obs;
    return Column(
      children: [
        const SizedBox(height: ZSizes.spaceBtwItems * 1.5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              () => showWalletAmount.value
                  ? Text(
                      'Rs. ${userController.GYMuser.value.balance.toInt() ?? 0.0}',
                      style: Get.textTheme.displayMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : Container(
                      width: 150,
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20))),
                    ),
            ),
            const SizedBox(
              width: 20,
            ),
            Obx(
              () => IconButton(
                onPressed: () =>
                    showWalletAmount.value = !showWalletAmount.value,
                style:
                    IconButton.styleFrom(backgroundColor: Colors.grey.shade300),
                icon: Icon(
                    showWalletAmount.value ? Iconsax.eye_slash : Iconsax.eye),
              ),
            )
          ],
        ),
        const SizedBox(height: ZSizes.spaceBtwSections),
      ],
    );
  }

  final GlobalKey qrKey = GlobalKey();

  Future<void> _shareQRCode() async {
    try {
      if (qrKey.currentContext == null) {
        print('QR key context is null');
        return;
      }

      // Capture the widget as an image
      RenderRepaintBoundary boundary =
          qrKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

      // Convert the captured image to byte data
      var image = await boundary.toImage(pixelRatio: 3.0); // Image scaling
      ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
      var buffer = byteData!.buffer.asUint8List();

      // Share the image using esys_flutter_share_plus
      await Share.file(
        'qr_code.png', // File name (QR code image)
        'qr_code.png', // The name of the file
        buffer, // Byte data for the QR code image
        'image/png', // MIME type (PNG image)
      );

      ZLoaders.successSnackBar(title: 'Success', message: 'QR Code Shared!');
    } catch (e) {
      ZLogger.error('Error sharing QR code: $e');
      ZLoaders.errorSnackBar(
          title: 'Uh Snap!', message: 'Failed to share QR code');
    }
  }

  Widget _buildOngoingUsersList(
      HomeController homeController, BuildContext context) {
    return Obx(
      () {
        List<GymUserAttendance> onGoingUsers =
            homeController.userGYMAttendance.value
                .where(
                  (user) => DateTime.parse(user!.checkOutTime!.toString())
                      .isAfter(DateTime.now()),
                )
                .toList();

        return onGoingUsers.isNotEmpty
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Users in your GYM',
                    style: Get.textTheme.headlineMedium,
                  ),
                  ListView.builder(
                    padding: const EdgeInsets.symmetric(
                        vertical: ZSizes.spaceBtwItems),
                    itemCount: onGoingUsers.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (_, index) {
                      final user = onGoingUsers[index];
                      return ZCustomCard(
                        gymName: user.name,
                        gymCheckInDate:
                            DateFormat('dd-MM-yyy').format(user.checkInTime),
                        gymCheckInTime:
                            DateFormat('HH:mm a').format(user.checkInTime),
                        currentlyExercising: true,
                      );
                    },
                  ),
                ],
              )
            : _buildNoMembersYet();
      },
    );
  }

  Widget _buildNoMembersYet() {
    return Column(
      children: [
        const SizedBox(
          height: ZSizes.spaceBtwSections,
        ),
        Container(
          decoration: const BoxDecoration(
            color: ZColor.lightGrey,
            shape: BoxShape.circle,
          ),
          padding: const EdgeInsets.all(ZSizes.md),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Iconsax.personalcard,
              size: ZSizes.iconLg * 2,
              color: ZColor.primary,
            ),
          ),
        ),
        const SizedBox(height: ZSizes.sm),
        Text(
          'No members exercising yet',
          style: Get.textTheme.titleMedium!
              .copyWith(color: ZColor.primary, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: ZSizes.spaceBtwSections * 2,
        )
      ],
    );
  }

  Widget _buildVisitorsHistory() {
    return ListTile(
      leading: const Icon(Iconsax.task),
      title: Text('Go to visitors history', style: Get.textTheme.titleLarge),
      onTap: () => Get.to(() => const VisitorsScreen()),
    );
  }

  Widget _buildUpcomingEvents(UpcomingEventsController controller) {
    return Obx(
      () {
        List<dynamic> validEvents = controller.gymEvents.value
            .where((event) =>
                DateTime.parse(event.startTime).isAfter(DateTime.now()))
            .toList();

        return ListTile(
          leading: const Icon(Iconsax.flag),
          title: Text(
            'Upcoming Events${validEvents.isNotEmpty ? ' (${validEvents.length})' : ''}',
            style: Get.textTheme.titleLarge,
          ),
          onTap: () => Get.to(const UpcomingEventsScreen()),
        );
      },
    );
  }
}
