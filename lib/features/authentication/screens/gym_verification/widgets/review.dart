import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../utils/constants/sizes.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Let\'s Review your Data',
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
        Text(
          'Let\'s Add Your Bank Details',
          style: Theme.of(Get.context!).textTheme.headlineMedium,
        ),
        SizedBox(
          height: ZSizes.spaceBtwItems,
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Bank Name'),
        ),
        SizedBox(
          height: ZSizes.spaceBtwInputFields,
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Account Number'),
        ),
        SizedBox(
          height: ZSizes.spaceBtwInputFields,
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'IBAN'),
        ),
        SizedBox(
          height: ZSizes.spaceBtwInputFields,
        ),
      ],
    );
  }
}
