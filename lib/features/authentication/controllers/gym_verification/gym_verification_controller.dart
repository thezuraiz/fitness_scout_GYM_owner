import 'package:fitness_scout_owner_v1/features/authentication/screens/gym_verification/widgets/gym_info.dart';
import 'package:fitness_scout_owner_v1/features/authentication/screens/gym_verification/widgets/review.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../screens/gym_verification/widgets/bank_info.dart';

class GymVerificationController extends GetxController {
  /// Variable
  RxInt stepperCurrentIndex = 0.obs;

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
