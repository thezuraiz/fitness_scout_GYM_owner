import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../utils/helpers/logger.dart';
import '../../screens/login_screen.dart';

class OnBoardController extends GetxController {
  static OnBoardController get instance => Get.find();

  // --- VARIABLE
  final pageController = PageController();
  RxInt currentPageIndex = 0.obs;

  // --- UPDATE CURRENT INDEX WHEN PAGE SCROLL
  void updatePageIndicator(index) => currentPageIndex.value = index;

  // --- JUMP TO SPECIFIC DOTS
  void dotNavigationClick(index) {
    ZLogger.info("Clicked on Dot");
    currentPageIndex.value = index;
    pageController.jumpToPage(index);
  }

  // --- UPDATE CORRECT INDEX & JUMP TO NEXT PAGE
  void nextPage() {
    if (currentPageIndex.value == 2) {
      /// --- Local Storage
      final deviceStorage = GetStorage();
      deviceStorage.write('isFirstTime', false);
      Get.offAll(const LoginScreen());
      // currentPageIndex.value = 0;
      // pageController.jumpToPage(0);
    } else {
      ZLogger.info("Clicked Button");
      int page = currentPageIndex.value + 1;
      pageController.jumpToPage(page);
    }
  }

  // --- UPDATE CORRECT INDEX & JUMP TO LAST PAGE
  void skipPage() {
    currentPageIndex.value = 2;
    pageController.jumpToPage(2);
  }
}
