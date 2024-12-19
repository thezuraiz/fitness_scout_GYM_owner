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
  TextEditingController numberController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  /// Bank Details
  TextEditingController bankNameController = TextEditingController();
  TextEditingController bankAccountNoController = TextEditingController();
  TextEditingController bankAccountIBANController = TextEditingController();

  /// Update Name
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

  /// Update Number
  Future<void> updateUserNumber() async {
    try {
      FocusManager.instance.primaryFocus?.unfocus();

      // Start the Loader
      ZFullScreenLoader.openLoadingDialogy(
          'Processing your request...', ZImages.fileAnimation);

      if (numberController.text.trim() ==
          userController.GYMuser.value.contactNumber) {
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

      final Map<String, dynamic> json = {
        'contact_number': numberController.text.trim()
      };

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

  /// Update Website
  Future<void> updateUserWebsite() async {
    try {
      FocusManager.instance.primaryFocus?.unfocus();

      // Start the Loader
      ZFullScreenLoader.openLoadingDialogy(
          'Processing your request...', ZImages.fileAnimation);

      if (websiteController.text.trim() ==
          userController.GYMuser.value.website) {
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

      final Map<String, dynamic> json = {
        'website': numberController.text.trim()
      };

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

  /// Update Description
  Future<void> updateUserDescription() async {
    try {
      FocusManager.instance.primaryFocus?.unfocus();

      // Start the Loader
      ZFullScreenLoader.openLoadingDialogy(
          'Processing your request...', ZImages.fileAnimation);

      if (descriptionController.text.trim() ==
          userController.GYMuser.value.description) {
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

      final Map<String, dynamic> json = {
        'description': descriptionController.text.trim()
      };

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
        message: 'Description has been updated',
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

  /// Update Address
  Future<void> updateUserAddress() async {
    try {
      FocusManager.instance.primaryFocus?.unfocus();

      // Start the Loader
      ZFullScreenLoader.openLoadingDialogy(
          'Processing your request...', ZImages.fileAnimation);

      if (addressController.text.trim() ==
          userController.GYMuser.value.address) {
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

      final Map<String, dynamic> json = {
        'address': addressController.text.trim()
      };

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
        message: 'Description has been updated',
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

  /// =================== Bank Details =======================

  /// Update Bank Name
  Future<void> updateBankDetails(String fieldName, String fieldValue) async {
    try {
      FocusManager.instance.primaryFocus?.unfocus();

      // Start the Loader
      ZFullScreenLoader.openLoadingDialogy(
          'Processing your request...', ZImages.fileAnimation);

      // if (bankNameController.text.trim() ==
      //     userController.GYMuser.value.ownerBankDetails!.bankName) {
      //   ZLoaders.warningSnackBar(
      //     title: 'Warning',
      //     message: 'No changes detected. Please update and try again',
      //   );
      //   ZFullScreenLoader.stopLoading();
      //   return;
      // }

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

      // final Map<String, dynamic> json = {
      //   'owner_bank_details': addressController.text.trim()
      // };

      // Update the fields in Firestore
      await userRepository.updateSingleFieldInBankDetails(
          fieldName, fieldValue);

      // Update RX Values dynamically
      await userController.fetchUserRecord();
      userController.refresh();

      // Remove the Loader
      ZFullScreenLoader.stopLoading();

      Get.back();
      // Show Success Message
      ZLoaders.successSnackBar(
        title: 'Success',
        message: 'Bank Details has been updated',
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
