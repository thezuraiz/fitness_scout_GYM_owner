import 'package:flutter/material.dart';

import '../../features/authentication/controllers/login/login_controller.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/image_string.dart';
import 'package:get/get.dart';
import '../../utils/constants/sizes.dart';

class ZSocialButtons extends StatelessWidget {
  const ZSocialButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: ZColor.grey)),
          child: IconButton(
            onPressed: () => controller.googleSignIn(),
            icon: const Image(
              height: ZSizes.iconMd,
              width: ZSizes.iconMd,
              image: AssetImage(ZImages.google),
            ),
          ),
        ),
        const SizedBox(
          width: ZSizes.spaceBtwItems,
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: ZColor.grey)),
          child: IconButton(
            onPressed: () {},
            icon: const Image(
              height: ZSizes.iconMd,
              width: ZSizes.iconMd,
              image: AssetImage(ZImages.facebook),
            ),
          ),
        )
      ],
    );
  }
}
