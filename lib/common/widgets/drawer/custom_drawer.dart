import 'package:fitness_scout_owner_v1/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../socialButtons.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = ZHelperFunction.isDarkMode(context);
    return Drawer(
      elevation: 100,
      child: Container(
        color: dark ? ZColor.dark : ZColor.primary,
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: dark ? ZColor.dark : ZColor.primary,
              ),
              accountName: const Text(
                "Zuraiz Khan",
              ),
              currentAccountPicture: const CircleAvatar(
                backgroundImage: AssetImage(
                    "assets/user_profile/user_profile_compressed.png"),
                backgroundColor: ZColor.light,
              ),
              accountEmail: const Text("thezuraiz@gmail.com"),
            ),
            ListTile(
              leading: const Icon(Iconsax.location,
                  color: ZColor.light, size: ZSizes.iconMd),
              title: Text("GYM Location",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: ZColor.light)),
              onTap: () {},
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Iconsax.wallet,
                  color: ZColor.light, size: ZSizes.iconLg),
              title: Text("Wallet",
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(color: ZColor.light)),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Iconsax.security_safe,
                  color: ZColor.light, size: ZSizes.iconLg),
              title: Text("Safety",
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(color: ZColor.light)),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                'Settings',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(color: ZColor.light),
              ),
              leading: const Icon(Iconsax.setting,
                  color: ZColor.light, size: ZSizes.iconLg),
              onTap: () {},
            ),
            ListTile(
              title: Text('FAQ',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(color: ZColor.light)),
              leading: const Icon(Iconsax.info_circle,
                  color: ZColor.light, size: ZSizes.iconLg),
              onTap: () {},
            ),
            ListTile(
              title: Text('Support',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(color: ZColor.light)),
              leading: const Icon(Iconsax.message,
                  color: ZColor.light, size: ZSizes.iconLg),
              onTap: () {},
            ),
            const Spacer(),
            const Divider(),
            const SizedBox(
              height: ZSizes.spaceBtwSections,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [ZSocialButtons()],
            ),
            const SizedBox(
              height: ZSizes.spaceBtwSections,
            )
          ],
        ),
      ),
    );
  }
}
