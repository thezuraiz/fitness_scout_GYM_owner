import 'dart:io';

import 'package:fitness_scout_owner_v1/features/authentication/controllers/gym_verification/gym_verification_controller.dart';
import 'package:fitness_scout_owner_v1/utils/validator/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants/sizes.dart';

class GymInfoScreen extends StatelessWidget {
  const GymInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GymVerificationController());

    return Form(
      // key: controller.formKeys[0],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Let\'s Register Your GYM',
            style: Theme.of(Get.context!).textTheme.headlineMedium,
          ),
          const SizedBox(
            height: ZSizes.spaceBtwSections,
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'GYM Name'),
            validator: (value) =>
                ZValidation.validateEmptyText('GYM Name', value),
            controller: controller.gymName,
          ),
          const SizedBox(
            height: ZSizes.spaceBtwInputFields,
          ),
          const SizedBox(height: ZSizes.spaceBtwInputFields),
          TextFormField(
            decoration: const InputDecoration(labelText: 'GYM Address'),
            validator: (value) =>
                ZValidation.validateEmptyText('GYM Address', value),
            controller: controller.gymAddress,
          ),
          // Padding(
          //   padding: const EdgeInsets.all(16.0),
          //   child: Text(
          //     'Select Opening Hours',
          //     style: TextStyle(
          //       fontSize: 24,
          //       fontWeight: FontWeight.bold,
          //       color: Colors.black87,
          //     ),
          //   ),
          // ),
          // const SizedBox(height: 20),
          // ListView(
          //   physics: NeverScrollableScrollPhysics(),
          //   shrinkWrap: true,
          //   children: openingHours.keys.map((day) {
          //     return Card(
          //       margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          //       child: Column(
          //         children: [
          //           ListTile(
          //             title: Text(day),
          //             trailing: ToggleButtons(
          //               children: <Widget>[
          //                 Padding(
          //                   padding:
          //                       const EdgeInsets.symmetric(horizontal: 16.0),
          //                   child: Text('Closed'),
          //                 ),
          //                 Padding(
          //                   padding:
          //                       const EdgeInsets.symmetric(horizontal: 16.0),
          //                   child: Text('Open'),
          //                 ),
          //               ],
          //               isSelected: [
          //                 !openingHours[day]!['isOpen']!,
          //                 openingHours[day]!['isOpen']!
          //               ],
          //               onPressed: (int index) {
          //                 setState(() {
          //                   openingHours[day]!['isOpen'] =
          //                       index == 1; // Update isOpen state
          //                   if (index == 0) {
          //                     // If selected 'Closed', reset times
          //                     openingHours[day]!['opening'] = null;
          //                     openingHours[day]!['closing'] = null;
          //                   }
          //                 });
          //               },
          //             ),
          //           ),
          //           if (openingHours[day]!['isOpen']!)
          //             Column(
          //               children: [
          //                 ListTile(
          //                   title: Text(
          //                       'Opening Time: ${openingHours[day]!['opening']?.format(context) ?? 'Select Opening Time'}'),
          //                   trailing: IconButton(
          //                     icon: Icon(Icons.access_time),
          //                     onPressed: () {
          //                       _selectTime(context, day, true);
          //                     },
          //                   ),
          //                 ),
          //                 ListTile(
          //                   title: Text(
          //                       'Closing Time: ${openingHours[day]!['closing']?.format(context) ?? 'Select Closing Time'}'),
          //                   trailing: IconButton(
          //                     icon: Icon(Icons.access_time),
          //                     onPressed: () {
          //                       _selectTime(context, day, false);
          //                     },
          //                   ),
          //                 ),
          //               ],
          //             ),
          //         ],
          //       ),
          //     );
          //   }).toList(),
          // ),
          const SizedBox(
            height: ZSizes.spaceBtwInputFields,
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'GYM Location'),
            enabled: false,
            controller: controller.gymLocation,
          ),
          const SizedBox(
            height: ZSizes.spaceBtwInputFields,
          ),
          GestureDetector(
            onTap: () => controller.pickImage(),
            child: Obx(() {
              // Ensure gymLicenseImage has a value before using it
              if (controller.gymLicenseImage.value != null) {
                // Convert XFile to File
                final file = File(controller.gymLicenseImage.value!.path);

                return Image.file(
                  file, // Use the File object here
                  fit: BoxFit.cover,
                  height: 100,
                  width: 100,
                );
              } else {
                return Container(
                  height: 100,
                  width: 100,
                  color: Colors.grey, // Placeholder for no image
                  child: Center(child: Text('No Image Selected')),
                );
              }
            }),
          ),
          Obx(() {
            final isInvalid = controller.gymLicenseImage.value;
            return isInvalid == null
                ? Text(
                    'Required',
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: Colors.red.shade900,
                        fontWeight: FontWeight.w500),
                  )
                : SizedBox
                    .shrink(); // Provide an empty widget when the condition is false
          }),
          const SizedBox(
            height: ZSizes.spaceBtwInputFields,
          ),
          TextFormField(
            decoration:
                const InputDecoration(labelText: 'GYM Website (Optional)'),
            controller: controller.gymWebsite,
          ),
          const SizedBox(
            height: ZSizes.spaceBtwInputFields,
          ),
        ],
      ),
    );
  }
}
