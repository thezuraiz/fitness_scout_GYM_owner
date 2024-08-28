import 'package:fitness_scout_owner_v1/common/widgets/custom_appbar/custom_app_bar.dart';
import 'package:fitness_scout_owner_v1/common/widgets/drawer/custom_drawer.dart';
import 'package:fitness_scout_owner_v1/common/widgets/formDivider.dart';
import 'package:fitness_scout_owner_v1/common/widgets/socialButtons.dart';
import 'package:fitness_scout_owner_v1/utils/constants/colors.dart';
import 'package:fitness_scout_owner_v1/utils/constants/sizes.dart';
import 'package:fitness_scout_owner_v1/utils/helpers/helper_functions.dart';

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = ZHelperFunction.isDarkMode(context);
    return Scaffold(
        drawer: CustomDrawer(),
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 160,
                child: FlutterSwitch(
                  width: double.infinity,
                  height: 50.0,
                  valueFontSize: 25.0,
                  toggleSize: 45.0,
                  value: true,
                  borderRadius: 30.0,
                  padding: 10.0,
                  showOnOff: true,
                  onToggle: (val) {},
                  activeText: 'Online',
                  inactiveText: 'Offline',
                  activeColor: Colors.green,
                  inactiveColor: Colors.red,
                ),
              )
            ],
          ),
          actions: [IconButton(onPressed: () {}, icon: Icon(Iconsax.setting))],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: ZSizes.defaultSpace, horizontal: ZSizes.sm),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton(
                      child: Text('Day'),
                      onPressed: () {},
                    ),
                    OutlinedButton(
                      child: Text('Week'),
                      onPressed: () {},
                    ),
                    OutlinedButton(
                      child: Text('Month'),
                      onPressed: () {},
                    )
                  ],
                ),
                SizedBox(
                  height: ZSizes.spaceBtwSections,
                ),
                Text(
                  '0.00\$',
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: ZSizes.spaceBtwSections,
                ),
                ListTile(
                  leading: Icon(
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
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(ZSizes.lg),
                    ),
                  ),
                ),
                SizedBox(
                  height: ZSizes.spaceBtwSections * 2.5,
                ),
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: ZColor.lightGrey, shape: BoxShape.circle),
                      padding: EdgeInsets.all(ZSizes.sm),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Iconsax.home_1,
                          size: ZSizes.iconLg * 1.3,
                          color: ZColor.darkGrey,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: ZSizes.sm,
                    ),
                    Text(
                      'No completed orders',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: ZColor.grey),
                    )
                  ],
                ),
                SizedBox(
                  height: ZSizes.spaceBtwSections * 2.2,
                ),
                ListTile(
                  leading: Icon(Iconsax.task),
                  title: Text('Go to request hostory',
                      style: Theme.of(context).textTheme.titleLarge),
                ),
                ListTile(
                  leading: Icon(Iconsax.flag),
                  title: Text('Acheivements',
                      style: Theme.of(context).textTheme.titleLarge),
                )
              ],
            ),
          ),
        ));
  }
}
