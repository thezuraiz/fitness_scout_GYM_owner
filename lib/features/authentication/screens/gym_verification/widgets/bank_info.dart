import 'package:flutter/material.dart';

import '../../../../../utils/constants/sizes.dart';
import 'package:get/get.dart';

class BankInfoScreen extends StatelessWidget {
  const BankInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
