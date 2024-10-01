import 'package:fitness_scout_owner_v1/common/widgets/drawer/custom_drawer.dart';
import 'package:fitness_scout_owner_v1/utils/constants/colors.dart';
import 'package:fitness_scout_owner_v1/utils/constants/sizes.dart';
import 'package:fitness_scout_owner_v1/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:iconsax/iconsax.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = ZHelperFunction.isDarkMode(context);
    return Scaffold(
      drawer: const CustomDrawer(),
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(ZSizes.defaultSpace),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: dark ? ZColor.darkContainer : ZColor.lightGrey,
                borderRadius: BorderRadius.circular(ZSizes.md),
              ),
              padding: const EdgeInsets.all(ZSizes.md),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          leading: Container(
                            padding: const EdgeInsets.all(ZSizes.md),
                            decoration: const BoxDecoration(
                                color: ZColor.grey, shape: BoxShape.circle),
                            child: Icon(
                              Iconsax.coin_1,
                              color: dark ? ZColor.dark : ZColor.darkerGrey,
                            ),
                          ),
                          title: Text(
                            'Balance',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          trailing: const Icon(Icons.question_mark),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: ZSizes.spaceBtwSections,
                  ),
                  ListTile(
                    title: Text(
                      'PKR1300',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    trailing: const Icon(Iconsax.arrow_right_3),
                  ),
                  const SizedBox(
                    height: ZSizes.spaceBtwSections,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text('Top up'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: ZSizes.spaceBtwSections,
            ),
            Container(
              decoration: BoxDecoration(
                  color: dark ? ZColor.darkContainer : ZColor.lightGrey,
                  borderRadius: BorderRadius.circular(ZSizes.md)),
              padding: const EdgeInsets.all(ZSizes.sm),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          title: Text(
                            'Payment methods you provide',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: ZSizes.sm,
                  ),
                  ListTile(
                    title: Text(
                      'JazzCash',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    trailing: Switch(
                      value: true,
                      onChanged: (value) {},
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'EasyPaisa',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    trailing: Switch(
                      value: true,
                      onChanged: (value) {},
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(ZSizes.md),
                    margin: const EdgeInsets.all(ZSizes.sm),
                    decoration: BoxDecoration(
                        color: dark ? ZColor.darkContainer : ZColor.white,
                        borderRadius:
                            BorderRadius.circular(ZSizes.cardRadiusSm)),
                    child: Text(
                      'To see method available for other services, visit their pages in side menu',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
