import 'package:fitness_scout_owner_v1/features/authentication/controllers/gym_verification/gym_verification_controller.dart';
import 'package:fitness_scout_owner_v1/features/authentication/screens/gym_verification/gym_registration_waiting_list.dart';
import 'package:fitness_scout_owner_v1/utils/constants/colors.dart';
import 'package:fitness_scout_owner_v1/utils/constants/sizes.dart';
import 'package:fitness_scout_owner_v1/utils/theme/custom_themes/elevated_button_theme.dart';
import 'package:fitness_scout_owner_v1/utils/theme/custom_themes/outlined_button.dart';
import 'package:fitness_scout_owner_v1/utils/theme/custom_themes/textformfield_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class GymVerificationScreen extends StatelessWidget {
  const GymVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GymVerificationController());
    return Obx(
      () => Scaffold(
          body: SafeArea(
        child: Theme(
          data: ThemeData(
              primarySwatch: Colors.orange,
              elevatedButtonTheme:
                  ZElevatedButtonTheme.lightElevatedButtonTheme,
              inputDecorationTheme: ZTextFormFieldTheme.lightTextFormField,
              outlinedButtonTheme: ZOutlinedButton.lightOutlinedButtonTheme,
              colorScheme: const ColorScheme.light(primary: Colors.orange)),
          child: Stepper(
            stepIconBuilder: (int stepIndex, StepState stepState) => const Icon(
              Iconsax.note,
              color: ZColor.light,
              size: 16,
            ),
            steps: controller.steps(),
            currentStep: controller.stepperCurrentIndex.value,
            type: StepperType.horizontal,
            onStepContinue: () {
              if (controller.isLastStep) {
                Get.offAll(() => const GymRegistrationWaitingList());
              } else {
                controller.stepperCurrentIndex.value++;
              }
            },
            elevation: 0,
            onStepTapped: (i) => controller.stepperCurrentIndex.value = i,
            onStepCancel: () {
              if (controller.stepperCurrentIndex.value > 0) {
                controller.stepperCurrentIndex.value--;
              }
            },
            controlsBuilder: (BuildContext context, ControlsDetails controls) {
              final isLastStep = controller.isLastStep;
              return Column(
                children: <Widget>[
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (controller.validateCurrentStep()) {
                          controls.onStepContinue;
                        }
                      },
                      child: Text(isLastStep ? 'Finish' : 'Next'),
                    ),
                  ),
                  if (controller.stepperCurrentIndex.value > 0)
                    const SizedBox(
                        height: ZSizes.spaceBtwItems, width: ZSizes.md),
                  if (controller.stepperCurrentIndex.value > 0)
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: controls.onStepCancel,
                        child: const Text('Back'),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      )),
    );
  }
}
