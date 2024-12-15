import 'package:fitness_scout_owner_v1/features/gym/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';

import '../../../common/widgets/cards/custom_cards.dart';
import '../../../common/widgets/shimmer/shimmer.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';

class VisitorsScreen extends StatelessWidget {
  const VisitorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = HomeController.instance;
    final dark = ZHelperFunction.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Visitors History',
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: ZHelperFunction.isDarkMode(context)
                  ? Colors.white
                  : Colors.black),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => controller.loadUserAttendance(),
        child: Obx(
          () => Padding(
            padding: const EdgeInsets.all(ZSizes.defaultSpace),
            child: controller.isLoading.value == true
                ? ListView.builder(
                    itemCount: 3,
                    shrinkWrap: true,
                    itemBuilder: (_, __) => Card(
                      margin: const EdgeInsets.symmetric(vertical: ZSizes.sm),
                      color: dark ? ZColor.darkGrey : ZColor.lightContainer,
                      child: const ListTile(
                        contentPadding: EdgeInsets.all(1),
                        title: ZShimmerEffect(width: 30, height: 10),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ZShimmerEffect(width: double.infinity, height: 10),
                            ZShimmerEffect(width: double.infinity, height: 10),
                          ],
                        ),
                      ),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.userGYMAttendance.length,
                    itemBuilder: (_, index) {
                      final singleAttendance =
                          controller.userGYMAttendance.value[index];
                      DateTime checkOutTime = singleAttendance.checkOutTime;
                      bool isOnGoing = checkOutTime.isAfter(DateTime.now());
                      return ZCustomCard(
                          gymName: singleAttendance.name,
                          gymCheckInDate: DateFormat('dd-MM-yyy')
                              .format(singleAttendance.checkInTime),
                          gymCheckInTime: DateFormat('HH:mm a')
                              .format(singleAttendance.checkInTime),
                          currentlyExercising: isOnGoing ? true : false);
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
