import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants/sizes.dart';

class GymInfoScreen extends StatelessWidget {
  const GymInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Let\'s Register Your GYM',
          style: Theme.of(Get.context!).textTheme.headlineMedium,
        ),
        SizedBox(
          height: ZSizes.spaceBtwSections,
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'GYM Name'),
        ),
        SizedBox(
          height: ZSizes.spaceBtwInputFields,
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'GYM Address'),
        ),
        SizedBox(
          height: ZSizes.spaceBtwInputFields,
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'GYM Location'),
        ),
        SizedBox(
          height: ZSizes.spaceBtwInputFields,
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'GYM License'),
        ),
        SizedBox(
          height: ZSizes.spaceBtwInputFields,
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'GYM Website (Optional)'),
        ),
        SizedBox(
          height: ZSizes.spaceBtwInputFields,
        ),
      ],
    );
  }
}
