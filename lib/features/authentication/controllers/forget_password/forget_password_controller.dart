import 'package:fitness_scout_owner_v1/utils/device/deviceUtilities.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../utils/constants/image_string.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loader.dart';
import '../../screens/signup_screen/reset_password.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  /// --- VARIABLES
  final email = TextEditingController();
  final forgetKey = GlobalKey<FormState>();

  /// --- Form Validation
  final emailValidation = MultiValidator([
    RequiredValidator(errorText: 'Required'),
    EmailValidator(errorText: 'Invalid Email')
  ]);

  /// --- SENT RESENT PASSWORD EMAIL
  sendPasswordResendEmail() async {
    try {
      // Todo: Remove Keyboard
      FocusManager.instance.primaryFocus!.unfocus();

      // Todo: Start Loader
      ZFullScreenLoader.openLoadingDialogy(
          'Processing your request...', ZImages.fileAnimation);

      // Todo: Check Internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        ZFullScreenLoader.stopLoading();
        return;
      }

      // Todo: Form Validation
      if (!forgetKey.currentState!.validate()) {
        ZFullScreenLoader.stopLoading();
        return;
      }

      // Todo: Send Email
      AuthenticationRepository.instance
          .sendPasswordResentEmail(email.text.trim());

      await ZDeviceUtils.playSound('sounds/email_send_notification.mp3');

      // Todo: Stop Loader
      ZFullScreenLoader.stopLoading();

      // Todo: Show Success Screen
      await ZLoaders.successSnackBar(
          title: 'Email Sent ${email.text.trim()}',
          message: 'Email Link Sent To Reset Your Password');

      // Todo: Redirect
      Get.to(() => ResetPassword(email: email.text.trim()));
    } catch (e) {
      ZFullScreenLoader.stopLoading();
      ZLoaders.errorSnackBar(title: 'Uh Snap!', message: e.toString());
    }
  }

  /// --- RESEND PASSWORD RESET EMAIL
  resendPasswordResendEmail(String email) async {
    try {
      // Todo: Remove Keyboard
      FocusManager.instance.primaryFocus!.unfocus();

      // Todo: Start Loader
      ZFullScreenLoader.openLoadingDialogy(
          'Processing your request...', ZImages.fileAnimation);

      // Todo: Check Internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        ZFullScreenLoader.stopLoading();
        return;
      }

      // Todo: Send Email
      AuthenticationRepository.instance.sendPasswordResentEmail(email);
      await ZDeviceUtils.playSound('sounds/email_send_notification.mp3');

      // Todo: Stop Loader
      ZFullScreenLoader.stopLoading();

      // Todo: Show Success Screen
      await ZLoaders.successSnackBar(
          title: 'Email Sent',
          message: 'Email Link Sent To Reset Your Password');
    } catch (e) {
      ZFullScreenLoader.stopLoading();
      ZLoaders.errorSnackBar(title: 'Uh Snap!', message: e.toString());
    }
  }
}
