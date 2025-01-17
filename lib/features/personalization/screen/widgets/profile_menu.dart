import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/sizes.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    super.key,
    required this.title,
    required this.subTitle,
    this.icon = Iconsax.arrow_right_34,
    this.onPressed,
  });

  final String title, subTitle;
  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding:
            const EdgeInsets.symmetric(vertical: ZSizes.spaceBtwItems / 1.5),
        child: Row(
          children: [
            Expanded(
              flex: 7,
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodySmall,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              flex: onPressed != null ? 5 : 6,
              child: Text(
                subTitle,
                style: Theme.of(context).textTheme.bodyMedium,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (onPressed != null)
              Expanded(
                  child: Icon(
                icon,
                size: 18,
              ))
          ],
        ),
      ),
    );
  }
}
