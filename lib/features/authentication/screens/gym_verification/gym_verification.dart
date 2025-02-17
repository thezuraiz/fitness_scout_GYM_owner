import 'package:fitness_scout_owner_v1/data/repositories/authentication/authentication_repository.dart';
import 'package:fitness_scout_owner_v1/features/authentication/controllers/gym_verification/gym_user_controller.dart';
import 'package:fitness_scout_owner_v1/utils/constants/colors.dart';
import 'package:fitness_scout_owner_v1/utils/constants/sizes.dart';
import 'package:fitness_scout_owner_v1/utils/helpers/helper_functions.dart';
import 'package:fitness_scout_owner_v1/utils/theme/custom_themes/elevated_button_theme.dart';
import 'package:fitness_scout_owner_v1/utils/theme/custom_themes/outlined_button.dart';
import 'package:fitness_scout_owner_v1/utils/theme/custom_themes/textTheme.dart';
import 'package:fitness_scout_owner_v1/utils/theme/custom_themes/textformfield_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class GymVerificationScreen extends StatelessWidget {
  const GymVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GYMUserController());
    final dark = ZHelperFunction.isDarkMode(context);
    return Obx(
      () => Scaffold(
          body: SafeArea(
        child: Theme(
          data: ThemeData(
              primarySwatch: Colors.orange,
              elevatedButtonTheme:
                  ZElevatedButtonTheme.lightElevatedButtonTheme,
              inputDecorationTheme: dark
                  ? ZTextFormFieldTheme.darkTextFormField
                  : ZTextFormFieldTheme.lightTextFormField,
              outlinedButtonTheme: dark
                  ? ZOutlinedButton.darkOutlinedButtonTheme
                  : ZOutlinedButton.lightOutlinedButtonTheme,
              textTheme:
                  dark ? ZTextTheme.darkTextTheme : ZTextTheme.lightTextTheme,
              colorScheme: const ColorScheme.light(primary: Colors.orange)),
          child: Stepper(
            stepIconBuilder: (int stepIndex, StepState stepState) => const Icon(
              Iconsax.note,
              color: ZColor.light,
              size: 16,
            ),
            steps: controller.steps(),
            currentStep: controller.stepperCurrentIndex.value,
            type: StepperType.vertical,
            onStepContinue: () {
              // if (controller.isLastStep) {
              //   Get.offAll(() => const GymRegistrationWaitingList());
              // } else {
              //   controller.stepperCurrentIndex.value++;
              // }
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
                        FocusManager.instance.primaryFocus!.unfocus();
                        if (!controller.isLastStep) {
                          controller.stepperCurrentIndex.value++;
                        } else {
                          if (controller.formKey.currentState!.validate()) {
                            controller.registerGYM();
                          }
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
