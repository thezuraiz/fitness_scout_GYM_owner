import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_scout_owner_v1/common/widgets/cards/custom_cards.dart';
import 'package:fitness_scout_owner_v1/common/widgets/custom_appbar/custom_app_bar.dart';
import 'package:fitness_scout_owner_v1/common/widgets/drawer/custom_drawer.dart';
import 'package:fitness_scout_owner_v1/features/authentication/controllers/gym_verification/gym_user_controller.dart';
import 'package:fitness_scout_owner_v1/features/authentication/models/gym_model.dart';
import 'package:fitness_scout_owner_v1/features/gym/controller/home_controller.dart';
import 'package:fitness_scout_owner_v1/features/gym/controller/upcoming_event.dart';
import 'package:fitness_scout_owner_v1/features/gym/screen/upcoming_event/events.dart';
import 'package:fitness_scout_owner_v1/features/gym/screen/visitors_screen.dart';
import 'package:fitness_scout_owner_v1/utils/constants/colors.dart';
import 'package:fitness_scout_owner_v1/utils/constants/sizes.dart';
import 'package:fitness_scout_owner_v1/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = ZHelperFunction.isDarkMode(context);
    final userController = Get.put(GYMUserController());
    final upcomingEventsController = Get.put(UpcomingEventsController());
    final homeController = Get.put(HomeController());
    final isValidEvent = upcomingEventsController.gymEvents.value
        .where(
            (event) => DateTime.parse(event.startTime).isBefore(DateTime.now()))
        .toList();
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Iconsax.setting))
        ],
      ),
      body: SingleChildScrollView(
        child: RefreshIndicator(
          onRefresh: () => homeController.loadUserAttendance(),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: ZSizes.defaultSpace, horizontal: ZSizes.sm),
            child: Column(
              children: [
                Obx(
                  () => !upcomingEventsController.showDelayOnQr.value
                      ? SizedBox(
                          width: Get.width / 2,
                          child: PrettyQrView.data(
                            data: FirebaseAuth.instance.currentUser!.uid
                                .toString(),
                            decoration: PrettyQrDecoration(
                              shape: PrettyQrSmoothSymbol(
                                  color: dark ? ZColor.white : Colors.black),
                            ),
                          ),
                        )
                      : const CircularProgressIndicator(
                          color: ZColor.primary,
                        ),
                ),
                const SizedBox(height: ZSizes.spaceBtwSections * 1.2),
                Obx(
                  () => Text(
                    '${userController.GYMuser.value.balance ?? 0.00}\$',
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: ZSizes.spaceBtwSections,
                ),
                ListTile(
                  leading: const Icon(
                    Iconsax.level,
                    size: ZSizes.iconLg * 1.3,
                    color: ZColor.light,
                  ),
                  title: Text(
                    'Set your daily income goal',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(color: ZColor.light),
                  ),
                  subtitle: Text(
                    'Take control of your earnings',
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: ZColor.light),
                  ),
                  tileColor: ZColor.primary,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(ZSizes.lg),
                    ),
                  ),
                ),
                const SizedBox(
                  height: ZSizes.spaceBtwSections * 2.5,
                ),
                Obx(() {
                  List<GymUserAttendance> onGoingUser = homeController
                      .userGYMAttendance.value
                      .where((user) =>
                          DateTime.parse(user.checkOutTime.toString())
                              .isAfter(DateTime.now()))
                      .toList();

                  return onGoingUser.length > 1
                      ? ListView.builder(
                          itemCount: onGoingUser.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (_, index) {
                            final user = onGoingUser[index];
                            return ZCustomCard(
                                gymName: user.name,
                                gymCheckInDate: DateFormat('dd-MM-yyy')
                                    .format(user.checkInTime),
                                gymCheckInTime: DateFormat('HH:mm a')
                                    .format(user.checkInTime),
                                currentlyExercising: true);
                          },
                        )
                      : Column(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                  color: ZColor.lightGrey,
                                  shape: BoxShape.circle),
                              padding: const EdgeInsets.all(ZSizes.sm),
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Iconsax.personalcard,
                                  size: ZSizes.iconLg * 1.3,
                                  color: ZColor.darkGrey,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: ZSizes.sm,
                            ),
                            Text(
                              'No members yet',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: ZColor.grey),
                            )
                          ],
                        );
                }),
                const SizedBox(
                  height: ZSizes.spaceBtwSections * 2,
                ),
                ListTile(
                  leading: const Icon(Iconsax.task),
                  title: Text('Go to visitors history',
                      style: Theme.of(context).textTheme.titleLarge),
                  onTap: () => Get.to(() => const VisitorsScreen()),
                ),
                ListTile(
                  leading: const Icon(Iconsax.flag),
                  title: Text(
                      'Upcoming Events${isValidEvent.length > 0 ? ' (${isValidEvent.length})' : ''}',
                      style: Theme.of(context).textTheme.titleLarge),
                  onTap: () => Get.to(const UpcomingEventsScreen()),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
