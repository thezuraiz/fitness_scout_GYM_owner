import 'package:get/get.dart';
import 'package:flutter/material.dart';

class GymVerificationController extends GetxController {
  /// Variable
  RxInt stepperCurrentIndex = 0.obs;

  List<Step> steps() => [
        Step(title: Text('Personal'), content: Column()),
        Step(title: Text('Work'), content: Column()),
        Step(title: Text('Complete'), content: Column()),
      ];

  bool get isFirstStep => stepperCurrentIndex.value == 0;

  bool get isLastStep => stepperCurrentIndex == steps().length - 1;
}
