import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_scout_owner_v1/common/widgets/drawer/custom_drawer.dart';
import 'package:fitness_scout_owner_v1/features/authentication/controllers/gym_verification/gym_user_controller.dart';
import 'package:fitness_scout_owner_v1/features/gym/controller/upcoming_event.dart';
import 'package:fitness_scout_owner_v1/features/gym/screen/upcoming_event/events.dart';
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
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        // title: Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     SizedBox(
        //       width: 160,
        //       child: FlutterSwitch(
        //         width: double.infinity,
        //         height: 50.0,
        //         valueFontSize: 25.0,
        //         toggleSize: 45.0,
        //         value: true,
        //         borderRadius: 30.0,
        //         padding: 10.0,
        //         showOnOff: true,
        //         onToggle: (val) {},
        //         activeText: 'Online',
        //         inactiveText: 'Offline',
        //         activeColor: Colors.green,
        //         inactiveColor: Colors.red,
        //       ),
        //     )
        //   ],
        // ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Iconsax.setting))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: ZSizes.defaultSpace, horizontal: ZSizes.sm),
          child: Column(
            children: [
              SizedBox(
                width: Get.width / 2,
                child: PrettyQrView.data(
                  data: FirebaseAuth.instance.currentUser!.uid.toString(),
                  decoration: PrettyQrDecoration(
                    shape: PrettyQrSmoothSymbol(
                        color: dark ? ZColor.white : Colors.black),
                  ),
                ),
              ),
              // Obx(() =>
              //     Text(userController.GYMuser.value.toJson().toString())),
              const SizedBox(height: ZSizes.spaceBtwSections * 0.5),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     OutlinedButton(
              //       child: const Text('Day'),
              //       onPressed: () {},
              //     ),
              //     OutlinedButton(
              //       child: const Text('Week'),
              //       onPressed: () {},
              //     ),
              //     OutlinedButton(
              //       child: const Text('Month'),
              //       onPressed: () {},
              //     )
              //   ],
              // ),
              const SizedBox(
                height: ZSizes.spaceBtwSections,
              ),
              Obx(
                    () =>
                    Text(
                      '${userController.GYMuser.value.balance ?? 0.00}\$',
                      style: Theme
                          .of(context)
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
                  style: Theme
                      .of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(color: ZColor.light),
                ),
                subtitle: Text(
                  'Take control of your earnings',
                  style: Theme
                      .of(context)
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
              Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        color: ZColor.lightGrey, shape: BoxShape.circle),
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
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: ZColor.grey),
                  )
                ],
              ),
              const SizedBox(
                height: ZSizes.spaceBtwSections * 2,
              ),
              ListTile(
                leading: const Icon(Iconsax.task),
                title: Text('Go to request hostory',
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleLarge),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Iconsax.flag),
                title: Text('Upcoming Events',
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleLarge),
                onTap: () => Get.to(const UpcomingEventsScreen()),
              )
            ],
          ),
        ),
      ),
    );
  }
}
