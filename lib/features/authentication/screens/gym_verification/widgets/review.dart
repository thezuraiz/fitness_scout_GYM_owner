import 'package:fitness_scout_owner_v1/features/authentication/controllers/gym_verification/gym_user_controller.dart';
import 'package:fitness_scout_owner_v1/features/authentication/screens/gym_verification/widgets/bank_info.dart';
import 'package:fitness_scout_owner_v1/features/authentication/screens/gym_verification/widgets/gym_gallery.dart';
import 'package:fitness_scout_owner_v1/features/authentication/screens/gym_verification/widgets/gym_info.dart';
import 'package:flutter/material.dart';
import '../../../../../utils/constants/sizes.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const GymInfoScreen(),
        Text(
          'GYM Images:',
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: ZSizes.spaceBtwSections * 0.7,
        ),
        const GymGallery(),
        const BankInfoScreen(),
      ],
    );
  }
}
