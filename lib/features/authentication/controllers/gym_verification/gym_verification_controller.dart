import 'package:fitness_scout_owner_v1/features/authentication/screens/gym_verification/widgets/gym_info.dart';
import 'package:fitness_scout_owner_v1/features/authentication/screens/gym_verification/widgets/review.dart';
import 'package:fitness_scout_owner_v1/features/gym/screen/home/home.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../screens/gym_verification/widgets/bank_info.dart';

class GymVerificationController extends GetxController {
  static GymVerificationController get instance => Get.find();

  /// - Variables

  RxInt stepperCurrentIndex = 0.obs;
  TextEditingController gymName = TextEditingController();
  TextEditingController gymAddress = TextEditingController();
  TextEditingController gymLocation = TextEditingController();
  TextEditingController gymLicence = TextEditingController();
  TextEditingController gymWebsite = TextEditingController();
  TextEditingController gymOwnerBankName = TextEditingController();
  TextEditingController gymOwnerAccountNumber = TextEditingController();
  TextEditingController gymOwnerAccountIBAN = TextEditingController();

  final formKeyStep1 = GlobalKey<FormState>();
  final formKeyStep2 = GlobalKey<FormState>();
  final formKeyStep3 = GlobalKey<FormState>();

  bool validateCurrentStep() {
    FormState? formState;
    if (stepperCurrentIndex.value == 0) {
      formState = formKeyStep1.currentState;
    } else if (stepperCurrentIndex.value == 1) {
      formState = formKeyStep2.currentState;
    } else if (stepperCurrentIndex.value == 2) {
      formState = formKeyStep3.currentState;
    }

    if (formState != null && formState.validate()) {
      formState.save();
      Get.offAll(() => const HomePage());
      return true;
    }
    return false;
  }

  List<Step> steps() => [
        Step(
            title: const Text('GYM Info'),
            isActive: stepperCurrentIndex.value >= 0,
            content: const GymInfoScreen()),
        Step(
            title: const Text('Banking Info'),
            isActive: stepperCurrentIndex.value >= 1,
            content: const BankInfoScreen()),
        Step(
            title: const Text('Review'),
            isActive: stepperCurrentIndex.value >= 3,
            content: const ReviewScreen()),
      ];

  bool get isFirstStep => stepperCurrentIndex.value == 0;

  bool get isLastStep => stepperCurrentIndex == steps().length - 1;
}
