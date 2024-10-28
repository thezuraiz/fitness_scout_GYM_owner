import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_scout_owner_v1/data/repositories/user/user_repository.dart';
import 'package:fitness_scout_owner_v1/features/authentication/screens/gym_verification/widgets/gym_info.dart';
import 'package:fitness_scout_owner_v1/features/authentication/screens/gym_verification/widgets/review.dart';
import 'package:fitness_scout_owner_v1/utils/helpers/logger.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../utils/constants/image_string.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loader.dart';
import '../../models/gym_model.dart';
import '../../screens/gym_verification/widgets/bank_info.dart';
import '../../screens/gym_verification/widgets/gym_timmings.dart';

class GymVerificationController extends GetxController {
  static GymVerificationController get instance => Get.find();

  /// - Variables

  RxInt stepperCurrentIndex = 0.obs;
  TextEditingController gymName = TextEditingController();
  TextEditingController gymAddress = TextEditingController();
  TextEditingController gymLocation = TextEditingController();
  TextEditingController gymWebsite = TextEditingController();
  TextEditingController gymOwnerBankName = TextEditingController();
  TextEditingController gymOwnerAccountNumber = TextEditingController();
  TextEditingController gymOwnerAccountIBAN = TextEditingController();
  Map<String, Map<String, dynamic?>> timings = {};

  final formKeyStep1 = GlobalKey<FormState>();
  final formKeyStep2 = GlobalKey<FormState>();
  final formKeyStep3 = GlobalKey<FormState>();

  bool get isFirstStep => stepperCurrentIndex.value == 0;

  bool get isLastStep => stepperCurrentIndex.value == steps().length - 1;

  final ImagePicker _picker = ImagePicker();
  Rx<XFile?> gymLicenseImage = Rx<XFile?>(null);

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
      gymLicenseImage.value = pickedFile;
    } else {
      print('No image selected');
    }
  }

  Future<void> registerGYM() async {
    FocusManager.instance.primaryFocus?.unfocus(); // Use ? to avoid null errors
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

      // Ensure gymLicenseImage is not null before using it
      if (gymLicenseImage.value != null) {
        final UploadedImage = await userRepository.uploadImage(
            '/GYMLicences', gymLicenseImage.value!);

        ZLogger.info('Uploaded Image $UploadedImage');

        try {
          /// Save GYM data in the Firebase Firestore
          final GYM = await GymOwnerModel(
              id: FirebaseAuth.instance.currentUser!.uid,
              name: '',
              username: '',
              email: '',
              gymName: gymName.text.toString() ?? '',
              license: UploadedImage ?? '',
              address: gymAddress.text.toString() ?? '',
              website: gymWebsite.text.toString() ?? '',
              location: Location(latitude: 20, longitude: 10),
              openingHours: timings,
              ownerBankDetails: OwnerBankDetails(
                  bankName: gymOwnerBankName.text.toString() ?? '',
                  accountNumber: gymOwnerAccountNumber.text.toString() ?? '',
                  iban: gymOwnerAccountIBAN.text.toString() ?? ''));

          ZLogger.info(GYM.toJson().toString());

          await userRepository.updateGYMRecord(GYM);
        } catch (e, t) {
          ZLogger.error('Error $e $t');
        }

        // Show Success Message
        ZLoaders.successSnackBar(
            title: 'Congratulations',
            message: 'Your account has been created! verify email to continue');

        ZFullScreenLoader.stopLoading();
      } else {
        ZLoaders.warningSnackBar(
            title: 'Uh Snap!', message: 'Please pick an image first.');
        ZFullScreenLoader.stopLoading();
      }
    } catch (e) {
      // Show some generic error to the user
      ZLoaders.warningSnackBar(title: 'Uh Snap!', message: e.toString());
      ZLogger.error(e.toString());
      ZFullScreenLoader.stopLoading();
    }
  }
}
