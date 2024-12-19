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
    final textColor = currentlyExercising
        ? Colors.white
        : dark
            ? ZColor.white // Ensure text is visible in dark mode
            : ZColor.dark;

    return ZRoundedContainer(
      width: double.infinity,
      backgroundColor:
          currentlyExercising ? ZColor.primary : Colors.transparent,
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
                      color: dark ? ZColor.white : ZColor.lightGrey,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: ZSizes.sm, vertical: ZSizes.sm / 2),
                    child: Text(
                      'On Going',
                      style: TextStyle(
                          color: dark
                              ? ZColor.primary
                              : ZColor.darkerGrey), // Adjust text color
                    ),
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
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: textColor,
                    ),
              ),
              const SizedBox(
                height: ZSizes.sm / 2,
              ),
              Text(
                "Check In Date: $gymCheckInDate",
                softWrap: true,
                style: TextStyle(color: textColor),
              ),
              const SizedBox(
                height: ZSizes.sm / 2,
              ),
              Text(
                "Check In Time: $gymCheckInTime",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: textColor),
              ),
            ],
          )
        ],
      ),
    );
  }
}
