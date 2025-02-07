import 'package:fitness_scout_owner_v1/features/gym/screen/home/home.dart';
import 'package:fitness_scout_owner_v1/features/gym/screen/wallet/wallet.dart';
import 'package:fitness_scout_owner_v1/utils/constants/colors.dart';
import 'package:fitness_scout_owner_v1/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    // Todo:
    // Get.put(UserController());
    final controller = Get.put(NavigationController());
    final dark = ZHelperFunction.isDarkMode(context);
    return Obx(
      () => Scaffold(
        bottomNavigationBar: NavigationBar(
          selectedIndex: controller.selectedIndex.value,
          elevation: 0,
          onDestinationSelected: (index) =>
              controller.selectedIndex.value = index,
          backgroundColor: dark
              ? ZColor.black.withOpacity(0.1)
              : ZColor.white.withOpacity(0.1),
          indicatorColor: dark
              ? ZColor.white.withOpacity(0.1)
              : ZColor.black.withOpacity(0.1),
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home), label: 'My Income'),
            NavigationDestination(icon: Icon(Iconsax.wallet), label: 'Wallet'),
          ],
        ),
        body: controller.screens[controller.selectedIndex.value],
      ),
    );
  }
}

class NavigationController extends GetxController {
  static NavigationController get instance => Get.find();

  RxInt selectedIndex = 0.obs;

  final screens = [
    HomePage(),
    const WalletScreen(),
  ];
}
