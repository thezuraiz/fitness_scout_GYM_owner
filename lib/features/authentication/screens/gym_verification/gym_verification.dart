import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';

import 'package:fitness_scout_owner_v1/features/authentication/controllers/gym_verification/gym_verification_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GymVerificationScreen extends StatelessWidget {
  const GymVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GymVerificationController());
    return Obx(
      () => Scaffold(
          body: SafeArea(
        child: Stepper(
          steps: controller.steps(),
          currentStep: controller.stepperCurrentIndex.value,
          type: StepperType.horizontal,
          onStepContinue: () {
            if (controller.isLastStep) {
            } else {
              controller.stepperCurrentIndex.value++;
            }
          },
        ),
      )),
    );
  }
}
