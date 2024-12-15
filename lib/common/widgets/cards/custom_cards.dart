import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../custom_cards/rounded_container.dart';

class ZCustomCard extends StatelessWidget {
  const ZCustomCard({
    super.key,
    required this.currentlyExercising,
    this.gymName = 'GYM Name',
    this.gymCheckInDate = '',
    this.gymCheckInTime = '',
  });

  final bool currentlyExercising;
  final String gymName, gymCheckInDate, gymCheckInTime;

  @override
  Widget build(BuildContext context) {
    final dark = ZHelperFunction.isDarkMode(context);
    return ZRoundedContainer(
      width: double.infinity,
      backgroundColor: currentlyExercising
          ? ZColor.primary.withOpacity(0.6)
          : Colors.transparent,
      showBorder: true,
      borderColor: currentlyExercising
          ? Colors.transparent
          : dark
              ? ZColor.darkerGrey
              : ZColor.grey,
      margin: const EdgeInsets.only(bottom: ZSizes.spaceBtwItems),
      padding: const EdgeInsets.all(ZSizes.md),
      child: Stack(
        children: [
          Positioned(
            right: 5,
            top: 0,
            child: currentlyExercising
                ? Container(
                    decoration: BoxDecoration(
                      color: dark ? ZColor.dark : ZColor.lightGrey,
                      borderRadius: BorderRadius.circular(
                        40,
                      ), // Makes the shape closer to a "stadium"
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: ZSizes.sm, vertical: ZSizes.sm / 2),
                    child: const Text('On Going'),
                  )
                : const Icon(null),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                gymName,
                softWrap: true,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: ZSizes.sm / 2,
              ),
              Text(
                "Check In Date: $gymCheckInDate",
                softWrap: true,
              ),
              const SizedBox(
                height: ZSizes.sm / 2,
              ),
              Text(
                "Check In Time: $gymCheckInTime",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          )
        ],
      ),
    );
  }
}
