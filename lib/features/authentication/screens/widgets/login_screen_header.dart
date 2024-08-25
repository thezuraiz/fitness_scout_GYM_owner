import 'package:flutter/material.dart';

import '../../../../utils/constants/image_string.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/helpers/helper_functions.dart';


class LoginScreenHeader extends StatelessWidget {
  const LoginScreenHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = ZHelperFunction.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: ZSizes.lg,
        ),
        Image.asset(
            height: 140, dark ? ZImages.lightAppLogo : ZImages.lightAppLogo),
        const SizedBox(
          height: ZSizes.sm,
        ),
        Text(
          ZText.loginTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(
          height: ZSizes.sm,
        ),
        Text(
          ZText.loginSubTitle,
          style: Theme.of(context).textTheme.bodySmall,
        )
      ],
    );
  }
}
