import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/widgets/loaders.dart';
import '../constants/colors.dart';
import '../helpers/helper_functions.dart';

class ZFullScreenLoader {
  static void openLoadingDialogy(String text, String animation) {
    showDialog(
        context: Get.overlayContext!,
        barrierDismissible: false,
        builder: (_) => PopScope(
              canPop: false,
              child: Container(
                color: ZHelperFunction.isDarkMode(Get.context!)
                    ? ZColor.dark
                    : ZColor.white,
                width: Get.width,
                height: Get.height,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 250,
                    ),
                    ZAnimationLoaderWidget(text: text, animation: animation)
                  ],
                ),
              ),
            ));
  }

  static void stopLoading() {
    Navigator.of(Get.context!).pop();
  }
}
