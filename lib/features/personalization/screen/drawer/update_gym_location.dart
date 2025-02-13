import 'package:fitness_scout_owner_v1/common/widgets/custom_appbar/custom_app_bar.dart';
import 'package:fitness_scout_owner_v1/common/widgets/section_heading.dart';
import 'package:fitness_scout_owner_v1/features/personalization/controller/update_gym_location_controller.dart';
import 'package:fitness_scout_owner_v1/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateGymLocation extends StatelessWidget {
  const UpdateGymLocation({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateGYMLocation());
    return Scaffold(
      appBar: ZCustomAppBar(
        title: Text(
          'Update GYM Location',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        showArrows: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ZSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Note: Updating your gym location will require approval, and users will be redirected to the new location.',
                style: TextStyle(color: Colors.red),
              ),
              Text(
                '\nWarning: Your gym account will be temporarily suspended until our support team reviews and approves it.',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(
                height: ZSizes.defaultSpace,
              ),
              const ZSectionHeading(
                title: 'Your New Address: ',
                showActionButton: false,
              ),
              const SizedBox(
                height: ZSizes.sm,
              ),
              Obx(() => Text(controller.address.value)),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => Padding(
            padding: const EdgeInsets.all(8.0),
            child: controller.locationFetched.value
                ? ElevatedButton(
                    onPressed: controller.updateLocation,
                    child: const Text('Update'))
                : const SizedBox()),
      ),
    );
  }
}
