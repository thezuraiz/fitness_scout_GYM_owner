import 'package:fitness_scout_owner_v1/utils/helpers/logger.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../data/repositories/user/user_repository.dart';
import '../../../utils/constants/image_string.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../../utils/popups/loader.dart';
import '../../authentication/controllers/gym_verification/gym_user_controller.dart';

class ChangeUserSettingsController extends GetxController {
  static ChangeUserSettingsController get instance => Get.find();

  final userController = GYMUserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateFormKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();

  /// Update User Fields
  Future<void> updateUserName() async {
    try {
      FocusManager.instance.primaryFocus?.unfocus();

      // Start the Loader
      ZFullScreenLoader.openLoadingDialogy(
          'Processing your request...', ZImages.fileAnimation);

      if (nameController.text.trim() == userController.GYMuser.value.name) {
        ZLoaders.warningSnackBar(
          title: 'Warning',
          message: 'No changes detected. Please update and try again',
        );
        ZFullScreenLoader.stopLoading();
        return;
      }

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        ZFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!updateFormKey.currentState!.validate()) {
        ZFullScreenLoader.stopLoading();
        return;
      }

      final Map<String, dynamic> json = {'name': nameController.text.trim()};

      // Update the fields in Firestore
      await userRepository.updateSingleField(json);

      // Update RX Values dynamically
      await userController.fetchUserRecord();
      userController.refresh();

      // Remove the Loader
      ZFullScreenLoader.stopLoading();

      Get.back();
      // Show Success Message
      ZLoaders.successSnackBar(
        title: 'Success',
        message: 'Your profile has been updated',
      );
    } catch (e) {
      // Remove the Loader
      ZFullScreenLoader.stopLoading();
      ZLoaders.errorSnackBar(
        title: 'Error',
        message: e.toString(),
      );
    }
  }
}
