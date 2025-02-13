import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/success_screen/successScreens.dart';
import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../utils/constants/image_string.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/popups/loader.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  /// Send Email whenever verify screen appears & set timer for auto redirect

  @override
  void onInit() {
    super.onInit();
    sendEmailVerification();
    setTimerForRedirect();
  }

  /// Send Email Verification Link
  sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
      ZLoaders.successSnackBar(
          title: 'Email Sent',
          message: 'Please check your inbox and verify your email');
    } catch (e) {
      ZLoaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  /// Timer to Automatically redirect on Email Verification
  setTimerForRedirect() {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user!.emailVerified ?? false) {
        timer!.cancel();
        Get.offAll(
          () => SuccessScreen(
            image: ZImages.staticSuccessIllustration,
            title: ZText.yourAccountCreatedTitle,
            subTitle: ZText.yourAccountCreatedSubTitle,
            onPressed: () => AuthenticationRepository.instance.screenRedirect(),
          ),
        );
      }
    });
  }

  /// Manually Check If Email verified
  checkEmailVerificationStatus() {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      Get.off(() => SuccessScreen(
            image: ZImages.staticSuccessIllustration,
            title: ZText.yourAccountCreatedTitle,
            subTitle: ZText.yourAccountCreatedSubTitle,
            onPressed: () => AuthenticationRepository.instance.screenRedirect(),
          ));
    }
  }
}
