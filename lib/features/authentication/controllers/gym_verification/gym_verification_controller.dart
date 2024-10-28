import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitness_scout_owner_v1/data/repositories/user/user_repository.dart';
import 'package:fitness_scout_owner_v1/features/authentication/screens/gym_verification/widgets/gym_info.dart';
import 'package:fitness_scout_owner_v1/features/authentication/screens/gym_verification/widgets/gym_timmings.dart';
import 'package:fitness_scout_owner_v1/features/authentication/screens/gym_verification/widgets/review.dart';
import 'package:fitness_scout_owner_v1/features/gym/screen/home/home.dart';
import 'package:fitness_scout_owner_v1/utils/helpers/logger.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../utils/constants/image_string.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loader.dart';
import '../../screens/gym_verification/widgets/bank_info.dart';

class GymVerificationController extends GetxController {
  static GymVerificationController get instance => Get.find();

  /// - Variables

  RxInt stepperCurrentIndex = 0.obs;
  TextEditingController gymName = TextEditingController();
  TextEditingController gymAddress = TextEditingController();
  TextEditingController gymLocation = TextEditingController();
  XFile? gymLicence;
  TextEditingController gymWebsite = TextEditingController();
  TextEditingController gymOwnerBankName = TextEditingController();
  TextEditingController gymOwnerAccountNumber = TextEditingController();
  TextEditingController gymOwnerAccountIBAN = TextEditingController();

  final formKeyStep1 = GlobalKey<FormState>();
  final formKeyStep2 = GlobalKey<FormState>();
  final formKeyStep3 = GlobalKey<FormState>();

  bool get isFirstStep => stepperCurrentIndex.value == 0;

  bool get isLastStep => stepperCurrentIndex == steps().length - 1;
  final ImagePicker _picker = ImagePicker();
  Rx<File?> gymLicenseImage = Rx<File?>(null);
  RxBool isUploading = false.obs;

  bool validateCurrentStep() {
    FormState? formState;
    if (stepperCurrentIndex.value == 0) {
      if (gymLicenseImage.value == null) {
        return false;
      }
      formState = formKeyStep1.currentState;
    } else if (stepperCurrentIndex.value == 1) {
      formState = formKeyStep2.currentState;
    } else if (stepperCurrentIndex.value == 2) {
      formState = formKeyStep3.currentState;
    }

    // if (formState != null && formState.validate()) {
    //   formState.save();
    //   Get.offAll(() => const HomePage());
    //   return true;
    // }
    return false;
  }

  List<Step> steps() => [
        Step(
            title: const Text('GYM Info'),
            isActive: stepperCurrentIndex.value >= 0,
            content: GymInfoScreen()),
        Step(
            title: const Text('GYM Timings'),
            isActive: stepperCurrentIndex.value >= 1,
            content: const GymTimingsScreen()),
        Step(
            title: const Text('Banking Info'),
            isActive: stepperCurrentIndex.value >= 1,
            content: const BankInfoScreen()),
        Step(
            title: const Text('Review'),
            isActive: stepperCurrentIndex.value >= 3,
            content: const ReviewScreen()),
      ];

  // Method to pick an image
  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      gymLicenseImage.value = File(pickedFile.path);
    } else {
      print('No image selected');
    }
  }

  Future<void> registerGYM() async {
    FocusManager.instance.primaryFocus!.unfocus();
    try {
      // Start Loading
      ZFullScreenLoader.openLoadingDialogy(
          'We are processing your information...', ZImages.fileAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        ZFullScreenLoader.stopLoading();
        return;
      }
      final userRepository = Get.put(UserRepository());

      final UploadedImage =
          await userRepository.uploadImage('/GYMLicences', gymLicence!);

      ZLogger.info('Uploaded Image $UploadedImage');

      /// Save GYM data in the Firebase Firestore
      // final GYM = GymOwnerModel(
      //   id: FirebaseAuth.instance.currentUser!.uid,
      //   gymName: gymName.text.toString(),
      //   license: UploadedImage,
      //   address: gymAddress.text.toString(),
      //   website: gymWebsite.text.toString(),
      // );

      // GymOwnerModel({
      // this.location,
      // this.address,
      // this.website,
      // this.license,
      // this.openingHours,
      // this.images,
      // this.amenities,
      // this.ownerBankDetails,
      // this.balance,
      // });

      // await userRepository.updateGYMRecord(GYM);

      // Show Successor Message
      ZLoaders.successSnackBar(
          title: 'Congratulations',
          message: 'Your account has been created! verify email to continue');

      ZFullScreenLoader.stopLoading();
    } catch (e) {
      //  Show some generic error to the user
      ZLoaders.warningSnackBar(title: 'Uh Snap!', message: e.toString());
      ZFullScreenLoader.stopLoading();
    }
  }
}
